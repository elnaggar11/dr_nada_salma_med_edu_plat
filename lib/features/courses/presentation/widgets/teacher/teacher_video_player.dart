import 'dart:collection';

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:no_screen_mirror/no_screen_mirror.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

class TeacherVideoPlayer extends StatelessWidget {
  final String videoUrl;
  final String? thumbnail;

  const TeacherVideoPlayer({super.key, required this.videoUrl, this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImage(
              imageUrl:
                  thumbnail ??
                  "https://img.youtube.com/vi/${_extractYoutubeId(videoUrl)}/maxresdefault.jpg",
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => _playInApp(context, videoUrl),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFF06523),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _extractYoutubeId(String url) {
    final regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*',
    );
    final match = regExp.firstMatch(url);
    return (match != null && match.groupCount >= 7) ? match.group(7)! : "";
  }

  void _playInApp(BuildContext context, String url) {
    bool isInvalidUrl = url.trim().isEmpty || 
                        url.trim().toLowerCase() == "drnadasalma.com" || 
                        url.trim().toLowerCase() == "https://drnadasalma.com";

    if (isInvalidUrl) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            "هذا الفيديو غير متاح",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    var validUrl = url;
    if (!validUrl.startsWith('http://') && !validUrl.startsWith('https://')) {
      validUrl = 'https://$validUrl';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _TeacherVideoPlayerScreen(validUrl: validUrl),
      ),
    );
  }
}

class _TeacherVideoPlayerScreen extends StatefulWidget {
  final String validUrl;

  const _TeacherVideoPlayerScreen({Key? key, required this.validUrl})
    : super(key: key);

  @override
  State<_TeacherVideoPlayerScreen> createState() =>
      _TeacherVideoPlayerScreenState();
}

class _TeacherVideoPlayerScreenState extends State<_TeacherVideoPlayerScreen>
    with WidgetsBindingObserver {
  InAppWebViewController? webView;
  static const MethodChannel _channel = MethodChannel(
    'com.drnadasalma/screen_record',
  );
  Timer? _androidRecordTimer;
  bool _isCurrentlyMuted = false;
  final _noScreenMirrorPlugin = NoScreenMirror.instance;
  StreamSubscription? _mirrorSubscription;
  bool isMirroring = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _noScreenMirrorPlugin.startListening();
    _mirrorSubscription = _noScreenMirrorPlugin.mirrorStream.listen((snapshot) {
      if (mounted) {
        setState(() {
          isMirroring = snapshot.isScreenMirrored;
        });
      }
    });

    _initScreenProtector();
  }

  Future<bool> _isAndroidScreenRecording() async {
    if (Platform.isAndroid) {
      try {
        return await _channel.invokeMethod('isScreenRecording');
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<void> _initScreenProtector() async {
    bool isRecording = await ScreenProtector.isRecording();

    if (Platform.isAndroid) {
      isRecording = await _isAndroidScreenRecording();
      _androidRecordTimer = Timer.periodic(const Duration(seconds: 2), (
        timer,
      ) async {
        final isRecordingNow = await _isAndroidScreenRecording();
        if (isRecordingNow && !_isCurrentlyMuted) {
          _isCurrentlyMuted = true;
          _muteVideo();
        } else if (!isRecordingNow && _isCurrentlyMuted) {
          _isCurrentlyMuted = false;
          _unmuteVideo();
        }
      });
    }

    if (isRecording) {
      _isCurrentlyMuted = true;
      _muteVideo();
    }
    ScreenProtector.addListener(null, (isRecording) {
      if (isRecording && !_isCurrentlyMuted) {
        _isCurrentlyMuted = true;
        _muteVideo();
      } else if (!isRecording && _isCurrentlyMuted) {
        _isCurrentlyMuted = false;
        _unmuteVideo();
      }
    });
  }

  void _muteVideo() async {
    await webView?.evaluateJavascript(
      source: '''
      window.postMessage('MUTE_VIDEO', '*');
      for (var i = 0; i < window.frames.length; i++) {
        window.frames[i].postMessage('MUTE_VIDEO', '*');
      }
    ''',
    );
  }

  void _unmuteVideo() async {
    await webView?.evaluateJavascript(
      source: '''
      window.postMessage('UNMUTE_VIDEO', '*');
      for (var i = 0; i < window.frames.length; i++) {
        window.frames[i].postMessage('UNMUTE_VIDEO', '*');
      }
    ''',
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isCurrentlyMuted = true;
      _muteVideo();
    } else if (state == AppLifecycleState.resumed) {
      bool isRecording = await ScreenProtector.isRecording();
      if (Platform.isAndroid) {
        isRecording = await _isAndroidScreenRecording();
      }
      if (!isRecording) {
        _isCurrentlyMuted = false;
        _unmuteVideo();
      }
    }
  }

  @override
  void dispose() {
    _androidRecordTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    ScreenProtector.removeListener();
    _mirrorSubscription?.cancel();
    _noScreenMirrorPlugin.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isMirroring) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              const Text(
                "مشاركة أو تسجيل الشاشة غير مسموحة لأسباب أمنية",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: hasError
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 50),
                  const SizedBox(height: 10),
                  const Text(
                    "هذا الفيديو غير متاح حالياً",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              )
            : AspectRatio(
          aspectRatio: 16 / 9,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.validUrl)),
            onWebViewCreated: (controller) => webView = controller,
            onLoadError: (controller, url, code, message) {
              setState(() => hasError = true);
            },
            onLoadHttpError: (controller, url, statusCode, description) {
              setState(() => hasError = true);
            },
            onLoadStop: (controller, url) async {
              // Inject CSS to hide Google Drive and OneDrive headers, buttons, and popouts
              await controller.evaluateJavascript(
                source: '''
                var style = document.createElement('style');
                style.innerHTML = `
                  .ndfHFb-c4YZDc-Wrql6b, /* Drive Popout button */
                  .ndfHFb-c4YZDc-GSQQnc-LgbsSe, /* Drive Top bar buttons */
                  .ndfHFb-c4YZDc-j7LFlb, /* Drive Header */
                  .od-ItemContent-header, /* OneDrive header */
                  .od-Dialog-header, /* OneDrive dialog header */
                  .ms-CommandBar /* OneDrive command bar */
                  { display: none !important; }
                `;
                document.head.appendChild(style);
                
                var videos = document.getElementsByTagName('video');
                for(var i = 0; i < videos.length; i++) {
                  videos[i].setAttribute('controlsList', 'nodownload');
                  videos[i].setAttribute('disablePictureInPicture', 'true');
                  videos[i].setAttribute('disableRemotePlayback', 'true');
                  videos[i].setAttribute('x-webkit-airplay', 'deny');
                }
              ''',
              );

              final isRecording = await ScreenProtector.isRecording();
              if (isRecording) {
                _muteVideo();
              }
            },
            initialUserScripts: UnmodifiableListView([
              UserScript(
                source: '''
                  window.addEventListener('message', function(event) {
                    if (event.data === 'MUTE_VIDEO') {
                      document.querySelectorAll("video").forEach(v => {
                          v.muted = true;
                          v.volume = 0;
                      });
                      // YouTube specific
                      var ytPlayer = document.getElementById('movie_player') || document.querySelector('.html5-video-player');
                      if (ytPlayer && ytPlayer.mute) ytPlayer.mute();
                    } else if (event.data === 'UNMUTE_VIDEO') {
                      document.querySelectorAll("video").forEach(v => {
                          v.muted = false;
                          v.volume = 1;
                      });
                      // YouTube specific
                      var ytPlayer = document.getElementById('movie_player') || document.querySelector('.html5-video-player');
                      if (ytPlayer && ytPlayer.unMute) ytPlayer.unMute();
                    }
                  });
                ''',
                injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
                forMainFrameOnly: false,
              ),
            ]),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                userAgent:
                    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1",
                javaScriptEnabled: true,
                mediaPlaybackRequiresUserGesture: false,
                disableContextMenu: true,
                supportZoom: false,
              ),
              android: AndroidInAppWebViewOptions(
                builtInZoomControls: false,
                displayZoomControls: false,
              ),
              ios: IOSInAppWebViewOptions(
                allowsInlineMediaPlayback: true,
                sharedCookiesEnabled: true,
                allowsAirPlayForMediaPlayback: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
