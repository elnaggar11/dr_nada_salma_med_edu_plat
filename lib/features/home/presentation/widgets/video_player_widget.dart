import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/watch_course_cubit/watch_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:no_screen_mirror/no_screen_mirror.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String lectureVideo;
  final String courseId;
  final String lectureId;

  const VideoPlayerWidget({
    super.key,
    required this.lectureVideo,
    required this.courseId,
    required this.lectureId,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  InAppWebViewController? webView;
  bool loading = true;
  bool hasError = false;
  static const MethodChannel _channel = MethodChannel(
    'com.drnadasalma/screen_record',
  );
  Timer? _androidRecordTimer;
  bool _isCurrentlyMuted = false;
  final _noScreenMirrorPlugin = NoScreenMirror.instance;
  StreamSubscription? _mirrorSubscription;
  bool isMirroring = false;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Shared protection JS — injected into ALL frames (including iframes)
  // via initialUserScripts with forMainFrameOnly: false.
  // This solves the cross-origin iframe problem.
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String _protectionJs = '''
    (function() {
      // === APPROACH 1: CSS injection ===
      var style = document.createElement('style');
      style.innerHTML = `
        /* --- OneDrive top bar --- */
        [class*="OneUp-header"], [class*="OneUp-command"], [class*="OneUp-close"],
        [class*="OneUp-details"], [class*="CommandBar"], [class*="commandBar"],
        [class*="od-TopBar"], [class*="od-ItemHeader"], [class*="od-OverflowMenu"],
        [class*="od-Dialog-header"], [class*="ms-CommandBar"], [class*="Files-CommandBar"],
        /* --- Google Drive top bar & toolbar (desktop + mobile) --- */
        [class*="ndfHFb-c4YZDc-Wrql6b"], [class*="ndfHFb-c4YZDc-GSQQnc"],
        [class*="ndfHFb-c4YZDc-j7LFlb"], [class*="ndfHFb-c4YZDc-to915"],
        [class*="ndfHFb-c4YZDc-cYSp0e-DARUcf"], [class*="ndfHFb-c4YZDc-cYSp0e"],
        [class*="ndfHFb-c4YZDc-nJjxad"], [class*="ndfHFb-c4YZDc-vyDMJf"],
        /* --- Google Drive top bar container (hides entire top section) --- */
        [class*="ndfHFb-c4YZDc-Wrql6b-hOcTPc"], [class*="ndfHFb-c4YZDc-q77wGc"],
        [class*="ndfHFb-c4YZDc-GCYh9b"], [class*="ndfHFb-c4YZDc-i5oIFb"],
        /* --- Google Drive download banner / notification bar --- */
        [class*="ndfHFb-c4YZDc-RJLb9c"], [class*="ndfHFb-c4YZDc-LgbsSe"],
        [class*="ndfHFb-c4YZDc-TSZdd"], [class*="ndfHFb-c4YZDc-aTv5jf"],
        [class*="drive-viewer-toolstrip"], [class*="drive-viewer-toolbar"],
        /* --- Google Drive share/download by attribute --- */
        [data-tooltip="Share"], [data-tooltip="مشاركة"],
        [data-tooltip="Download"], [data-tooltip="تنزيل"],
        [data-tooltip="Open in new window"], [data-tooltip="فتح في نافذة جديدة"],
        [data-tooltip="More actions"], [data-tooltip="المزيد من الإجراءات"],
        [data-tooltip="Print"], [data-tooltip="طباعة"],
        [aria-label="Share"], [aria-label="مشاركة"],
        [aria-label="Download"], [aria-label="تنزيل"],
        /* --- Google Drive popover/menu items --- */
        [class*="goog-menuitem"][aria-label*="Download"],
        [class*="goog-menuitem"][aria-label*="Share"],
        [class*="goog-menuitem"][aria-label*="تنزيل"],
        [class*="goog-menuitem"][aria-label*="مشاركة"],
        /* --- YouTube AirPlay / Cast / Remote / Share --- */
        .ytp-airplay-button, .ytp-remote-button, .ytp-cast-button,
        .ytp-remote-playback-button, .ytp-share-button,
        .ytp-share-button-visible, .ytp-button[data-tooltip-target-id="ytp-share-button"],
        /* --- Generic button selectors (English + Arabic) --- */
        button[aria-label="Download"], button[aria-label="Close"],
        button[aria-label="Info"], button[aria-label="Details"],
        button[aria-label="View details"], button[aria-label="Share"],
        button[aria-label="More actions"], button[aria-label="Open in new window"],
        button[aria-label="Print"],
        button[aria-label="إغلاق"], button[aria-label="معلومات"],
        button[aria-label="التفاصيل"], button[aria-label="عرض التفاصيل"],
        button[aria-label="مشاركة"], button[aria-label="المزيد من الإجراءات"],
        button[aria-label="تنزيل"], button[aria-label="فتح في نافذة جديدة"],
        button[aria-label="طباعة"],
        button[aria-label="Play on TV"], button[aria-label="التشغيل على التلفزيون"],
        button[aria-label="AirPlay"], button[aria-label="Cast"],
        button[title="Play on TV"], button[title="Cast"], button[title="AirPlay"],
        button[title="Share"], button[title="مشاركة"],
        button[title="Download"], button[title="تنزيل"],
        /* --- automationid-based (OneDrive) --- */
        [data-automationid="closeButton"], [data-automationid="moreActionsButton"],
        [data-automationid="detailsPaneButton"], [data-automationid="shareButton"],
        [data-automationid="downloadButton"],
        /* --- download links --- */
        a[download], button[name="Download"] {
          display: none !important;
          visibility: hidden !important;
          opacity: 0 !important;
          pointer-events: none !important;
          width: 0 !important;
          height: 0 !important;
          overflow: hidden !important;
        }
      `;
      document.head.appendChild(style);

      // === APPROACH 2: Protect <video> elements directly ===
      function protectVideoElements() {
        var videos = document.getElementsByTagName('video');
        for (var i = 0; i < videos.length; i++) {
          videos[i].setAttribute('controlsList', 'nodownload noremoteplayback noplaybackrate');
          videos[i].setAttribute('disablePictureInPicture', 'true');
          videos[i].setAttribute('disableRemotePlayback', 'true');
          videos[i].setAttribute('x-webkit-airplay', 'deny');
          videos[i].addEventListener('contextmenu', function(e) { e.preventDefault(); });
        }
      }

      // === APPROACH 3: DOM removal with MutationObserver ===
      function removeUnwantedButtons() {
        var selectors = [
          // YouTube
          '.ytp-airplay-button', '.ytp-remote-button',
          '.ytp-cast-button', '.ytp-remote-playback-button',
          '.ytp-share-button', '.ytp-share-button-visible',
          'button[aria-label="Play on TV"]', 'button[aria-label="التشغيل على التلفزيون"]',
          'button[aria-label="AirPlay"]', 'button[aria-label="Cast"]',
          'button[data-tooltip-target-id="ytp-autonav-toggle-button"]',
          // Google Drive share
          'button[aria-label="Share"]', 'button[aria-label="مشاركة"]',
          '[data-tooltip="Share"]', '[data-tooltip="مشاركة"]',
          'button[title="Share"]', 'button[title="مشاركة"]',
          '[class*="ndfHFb-c4YZDc-cYSp0e-DARUcf"]', '[class*="ndfHFb-c4YZDc-cYSp0e"]',
          // Google Drive download
          'button[aria-label="Download"]', 'button[aria-label="تنزيل"]',
          '[data-tooltip="Download"]', '[data-tooltip="تنزيل"]',
          'button[title="Download"]', 'button[title="تنزيل"]',
          // Google Drive more actions / open in new window / print
          'button[aria-label="More actions"]', 'button[aria-label="المزيد من الإجراءات"]',
          '[data-tooltip="More actions"]', '[data-tooltip="المزيد من الإجراءات"]',
          'button[aria-label="Open in new window"]', 'button[aria-label="فتح في نافذة جديدة"]',
          'button[aria-label="Print"]', 'button[aria-label="طباعة"]',
          'a[download]'
        ];
        selectors.forEach(function(sel) {
          try {
            document.querySelectorAll(sel).forEach(function(el) { el.remove(); });
          } catch(e) {}
        });
        protectVideoElements();
      }

      // Run immediately
      protectVideoElements();
      removeUnwantedButtons();

      // Direct share & download button removal
      document.querySelectorAll('button[aria-label="Share"], button[aria-label="مشاركة"], button[aria-label="Download"], button[aria-label="تنزيل"]').forEach(e => e.remove());

      // Watch for any DOM changes and re-apply protections
      if (document.body) {
        var observer = new MutationObserver(function() {
          removeUnwantedButtons();
          document.querySelectorAll('button[aria-label="Share"], button[aria-label="مشاركة"], button[aria-label="Download"], button[aria-label="تنزيل"]').forEach(e => e.remove());
        });
        observer.observe(document.body, { childList: true, subtree: true });
      }

      // Persistent interval fallback — catches late-loaded buttons
      setInterval(function() {
        document.querySelectorAll('button[aria-label="Share"], button[aria-label="مشاركة"], button[aria-label="Download"], button[aria-label="تنزيل"], [data-tooltip="Share"], [data-tooltip="Download"], .ytp-share-button').forEach(e => e.remove());

        // Remove any element that contains download/share text (catches banners)
        document.querySelectorAll('a, button, div').forEach(function(el) {
          var text = el.textContent || '';
          if ((text.includes('تنزيل باستخدام') || text.includes('Download with') || text.includes('فتح باستخدام')) && el.closest && !el.closest('video')) {
            var parent = el.closest('[class*="ndfHFb"]') || el;
            parent.remove();
          }
        });
      }, 500);

      // Disable right-click / context menu
      document.addEventListener('contextmenu', function(e) { e.preventDefault(); });

      // Disable drag to prevent drag-saving media
      document.addEventListener('dragstart', function(e) { e.preventDefault(); });
    })();
  ''';

  /// Content blockers that block Cast/AirPlay SDK scripts at the NETWORK level.
  /// This prevents the buttons from being created in the DOM at all.
  /// This approach is resilient to CSS class name changes because it blocks
  /// the JavaScript files that create the buttons, not the buttons themselves.
  List<ContentBlocker> get _contentBlockers => [
    // Block Google Cast SDK (creates the Cast button in YouTube)
    ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: '.*cast\\.js.*'),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: '.*cast_sender.*'),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: '.*cast_framework.*'),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    ContentBlocker(
      trigger: ContentBlockerTrigger(
        urlFilter: '.*www\\.gstatic\\.com/cv/js/sender.*',
      ),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    ContentBlocker(
      trigger: ContentBlockerTrigger(
        urlFilter: '.*www\\.gstatic\\.com/eureka.*',
      ),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    // Block AirPlay discovery scripts
    ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: '.*airplay.*'),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    // Block remote playback scripts
    ContentBlocker(
      trigger: ContentBlockerTrigger(urlFilter: '.*remote_playback.*'),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
    // Block Google Drive download endpoints
    ContentBlocker(
      trigger: ContentBlockerTrigger(
        urlFilter: '.*drive\\.google\\.com/uc\\?.*export=download.*',
      ),
      action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
    ),
  ];

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

    // Trigger your Cubit / Bloc call
    context.read<WatchCourseCubit>().watchCourse(
      params: WatchCourseParams(
        courseId: widget.courseId,
        lectureId: widget.lectureId,
      ),
    );

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
    webView = null;
    super.dispose();
  }

  /// Filter out unnecessary console warnings
  bool _shouldIgnoreConsoleMessage(String message) {
    final ignoredWarnings = [
      'was preloaded using link preload', // Google Drive preload warning
      'Guessed coded size incorrectly', // GPU frame warning
    ];
    return ignoredWarnings.any((warning) => message.contains(warning));
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
      backgroundColor: Colors.black.withOpacity(0.2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 70),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 40,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back, color: Colors.red, size: 20),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<WatchCourseCubit, WatchCourseState>(
        listener: (context, state) {
          if (state is WatchCourseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  state.message == 'course_hasnt_started_yet'
                      ? "لم يبدأ الكورس بعد"
                      : state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is WatchCourseError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.message == 'course_hasnt_started_yet'
                      ? "لم يبدأ الكورس بعد"
                      : state.message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          String videoUrl = widget.lectureVideo.startsWith('http')
              ? widget.lectureVideo
              : 'https://drive.google.com/file/d/${widget.lectureVideo}/preview';

          if (videoUrl.contains('drive.google.com') &&
              videoUrl.contains('/view')) {
            videoUrl = '${videoUrl.split('/view').first}/preview';
          }

          bool isOneDrive =
              videoUrl.toLowerCase().contains('1drv.ms') ||
              videoUrl.toLowerCase().contains('onedrive');

          bool isGoogleDrive =
              videoUrl.toLowerCase().contains('drive.google.com') ||
              (!widget.lectureVideo.startsWith('http') &&
                  widget.lectureVideo.length > 5 &&
                  !widget.lectureVideo.contains('/'));

          bool isDirectVideo =
              isOneDrive ||
              videoUrl.toLowerCase().contains('.mp4') ||
              videoUrl.toLowerCase().contains('.m3u8') ||
              videoUrl.toLowerCase().contains('.webm') ||
              videoUrl.toLowerCase().contains('.mov') ||
              videoUrl.toLowerCase().contains('s3.amazonaws.com') ||
              videoUrl.toLowerCase().contains('amazonaws.com') ||
              (!isGoogleDrive && !isOneDrive && videoUrl.startsWith('http'));

          String? htmlData;

          if (isDirectVideo) {
            String mediaSourceUrl = videoUrl;
            if (isOneDrive) {
              mediaSourceUrl = videoUrl.contains('?')
                  ? '${videoUrl.split('?').first}?download=1'
                  : '$videoUrl?download=1';
            }

            htmlData =
                '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body { width: 100%; height: 100%; background-color: black; display: flex; justify-content: center; align-items: center; overflow: hidden; }
    video { width: 100%; height: 100%; max-height: 100vh; object-fit: contain; outline: none; }
  </style>
</head>
<body>
  <video src="$mediaSourceUrl" controls playsinline webkit-playsinline autoplay controlsList="nodownload noremoteplayback" disablePictureInPicture disableRemotePlayback x-webkit-airplay="deny">
    <source src="$mediaSourceUrl">
    Your browser does not support video playback.
  </video>
  <script>
    document.addEventListener('contextmenu', function(e) { e.preventDefault(); });
    document.addEventListener('dragstart', function(e) { e.preventDefault(); });
  </script>
</body>
</html>
''';
          } else if (isGoogleDrive) {
            htmlData =
                '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    html, body { width: 100%; height: 100%; background-color: black; overflow: hidden; }
    iframe { width: 100%; height: 100%; border: none; }
  </style>
</head>
<body>
  <iframe
    src="$videoUrl"
    allow="autoplay; encrypted-media"
    allowfullscreen
  ></iframe>
  <script>
    document.addEventListener('contextmenu', function(e) { e.preventDefault(); });
    document.addEventListener('dragstart', function(e) { e.preventDefault(); });
  </script>
</body>
</html>
''';
          }

          WebUri baseWebUri;
          try {
            final parsed = Uri.parse(videoUrl);
            if (parsed.hasScheme && parsed.host.isNotEmpty) {
              baseWebUri = WebUri('${parsed.scheme}://${parsed.host}');
            } else {
              baseWebUri = WebUri('https://drive.google.com');
            }
          } catch (_) {
            baseWebUri = WebUri('https://drive.google.com');
          }

          return Stack(
            alignment: Alignment.center,
            children: [
              // Make WebView expand to fill available space
              Positioned.fill(
                child: SizedBox(
                  width: context.width,
                  height: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: InAppWebView(
                      initialData: htmlData != null
                          ? InAppWebViewInitialData(
                              data: htmlData,
                              mimeType: 'text/html',
                              encoding: 'utf-8',
                              baseUrl: baseWebUri,
                            )
                          : null,
                      initialUrlRequest: htmlData == null
                          ? URLRequest(url: WebUri(videoUrl))
                          : null,
                      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                      // FIX 1: Inject JS into ALL frames (including iframes)
                      // forMainFrameOnly: false bypasses cross-origin
                      // restrictions at the WebView engine level.
                      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                      initialUserScripts: UnmodifiableListView([
                        UserScript(
                          source: _protectionJs,
                          injectionTime:
                              UserScriptInjectionTime.AT_DOCUMENT_END,
                          forMainFrameOnly:
                              false, // ← KEY: injects into iframes too
                        ),
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
                          injectionTime:
                              UserScriptInjectionTime.AT_DOCUMENT_START,
                          forMainFrameOnly: false,
                        ),
                      ]),
                      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                      // FIX 2: Block Cast/AirPlay SDK at NETWORK level
                      // This prevents the buttons from being created at all.
                      // Doesn't depend on CSS class names.
                      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                      initialSettings: InAppWebViewSettings(
                        userAgent:
                            "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1",
                        javaScriptEnabled: true,
                        useOnLoadResource: true,
                        mediaPlaybackRequiresUserGesture: false,
                        disableContextMenu:
                            true, // Prevents long press to save video
                        supportZoom:
                            false, // Prevents zooming out to see other elements
                        builtInZoomControls: false,
                        displayZoomControls: false,
                        allowsInlineMediaPlayback: true,
                        sharedCookiesEnabled: true,
                        allowsAirPlayForMediaPlayback: false,
                        contentBlockers: _contentBlockers,
                      ),
                      onWebViewCreated: (controller) => webView = controller,
                      onLoadStart: (controller, url) {
                        setState(() => loading = true);
                      },
                      onLoadStop: (controller, url) async {
                        setState(() => loading = false);
                        // Re-inject protection JS as a safety net (double injection)
                        // This catches any elements that loaded after the initial injection
                        await controller.evaluateJavascript(
                          source: _protectionJs,
                        );

                        // Check screen recording status on load
                        final isRecording = await ScreenProtector.isRecording();
                        if (isRecording) {
                          _muteVideo();
                        }
                      },
                      onLoadError: (controller, url, code, message) {
                        setState(() {
                          loading = false;
                          hasError = true;
                        });
                        debugPrint('WebView load error ($code): $message');
                      },
                      onLoadHttpError: (controller, url, statusCode, description) {
                        setState(() {
                          loading = false;
                          hasError = true;
                        });
                        debugPrint(
                          'WebView load http error ($statusCode): $description',
                        );
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        if (!_shouldIgnoreConsoleMessage(
                          consoleMessage.message,
                        )) {
                          debugPrint(
                            'WebView console: ${consoleMessage.message}',
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              if (hasError)
                Positioned.fill(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 50,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "هذا الفيديو غير متاح حالياً",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

              // Loading indicator
              // if (loading)
              //   Positioned.fill(
              //     child: Center(
              //       child: const CircularProgressIndicator(color: Colors.red),
              //     ),
              //   ),

              // Black overlay to cover OneDrive/Google Drive top bar buttons
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(height: 75, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }
}
