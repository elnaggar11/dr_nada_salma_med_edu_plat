import 'dart:collection';

import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/watch_course_cubit/watch_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  InAppWebViewController? webView;
  bool loading = true;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Shared protection JS — injected into ALL frames (including iframes)
  // via initialUserScripts with forMainFrameOnly: false.
  // This solves the cross-origin iframe problem.
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const String _protectionJs = '''
    (function() {
      // === APPROACH 1: CSS injection (fallback — may break with DOM changes) ===
      var style = document.createElement('style');
      style.innerHTML = `
        /* --- OneDrive top bar --- */
        [class*="OneUp-header"], [class*="OneUp-command"], [class*="OneUp-close"],
        [class*="OneUp-details"], [class*="CommandBar"], [class*="commandBar"],
        [class*="od-TopBar"], [class*="od-ItemHeader"], [class*="od-OverflowMenu"],
        [class*="od-Dialog-header"], [class*="ms-CommandBar"], [class*="Files-CommandBar"],
        /* --- Google Drive top bar --- */
        [class*="ndfHFb-c4YZDc-Wrql6b"], [class*="ndfHFb-c4YZDc-GSQQnc"],
        [class*="ndfHFb-c4YZDc-j7LFlb"], [class*="ndfHFb-c4YZDc-to915"],
        /* --- YouTube AirPlay / Cast / Remote --- */
        .ytp-airplay-button, .ytp-remote-button, .ytp-cast-button,
        .ytp-remote-playback-button,
        /* --- Generic button selectors (works even if class names change) --- */
        button[aria-label="Download"], button[aria-label="Close"],
        button[aria-label="Info"], button[aria-label="Details"],
        button[aria-label="View details"], button[aria-label="Share"],
        button[aria-label="More actions"], button[aria-label="Open in new window"],
        button[aria-label="إغلاق"], button[aria-label="معلومات"],
        button[aria-label="التفاصيل"], button[aria-label="عرض التفاصيل"],
        button[aria-label="مشاركة"], button[aria-label="المزيد من الإجراءات"],
        button[aria-label="تنزيل"], button[aria-label="فتح في نافذة جديدة"],
        button[aria-label="Play on TV"], button[aria-label="التشغيل على التلفزيون"],
        button[aria-label="AirPlay"], button[aria-label="Cast"],
        button[title="Play on TV"], button[title="Cast"], button[title="AirPlay"],
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

      // === APPROACH 2: Attribute-based protection (resilient to CSS class changes) ===
      // This targets <video> elements directly by tag name — never breaks with UI updates.
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

      // === APPROACH 3: DOM removal with MutationObserver (catches dynamically added buttons) ===
      // Instead of relying only on CSS class names, also match by button position/structure.
      function removeUnwantedButtons() {
        // Target by known selectors
        var selectors = [
          '.ytp-airplay-button', '.ytp-remote-button',
          '.ytp-cast-button', '.ytp-remote-playback-button',
          'button[aria-label="Play on TV"]', 'button[aria-label="التشغيل على التلفزيون"]',
          'button[aria-label="AirPlay"]', 'button[aria-label="Cast"]',
          'button[data-tooltip-target-id="ytp-autonav-toggle-button"]',
          // Google Drive buttons
          'button[aria-label="Download"]', 'button[aria-label="تنزيل"]',
          'button[aria-label="Open in new window"]', 'button[aria-label="فتح في نافذة جديدة"]',
          'a[download]'
        ];
        selectors.forEach(function(sel) {
          try {
            document.querySelectorAll(sel).forEach(function(el) { el.remove(); });
          } catch(e) {}
        });

        // Also protect any new video elements added dynamically
        protectVideoElements();
      }

      // Run immediately
      protectVideoElements();
      removeUnwantedButtons();

      // Watch for any DOM changes and re-apply protections
      if (document.body) {
        var observer = new MutationObserver(function() { removeUnwantedButtons(); });
        observer.observe(document.body, { childList: true, subtree: true });
      }

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
          trigger: ContentBlockerTrigger(
            urlFilter: '.*cast\\.js.*',
          ),
          action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
        ),
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: '.*cast_sender.*',
          ),
          action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
        ),
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: '.*cast_framework.*',
          ),
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
          trigger: ContentBlockerTrigger(
            urlFilter: '.*airplay.*',
          ),
          action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
        ),
        // Block remote playback scripts
        ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: '.*remote_playback.*',
          ),
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
    // Trigger your Cubit / Bloc call
    context.read<WatchCourseCubit>().watchCourse(
      params: WatchCourseParams(
        courseId: widget.courseId,
        lectureId: widget.lectureId,
      ),
    );
  }

  @override
  void dispose() {
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

          bool isOneDrive =
              videoUrl.toLowerCase().contains('1drv.ms') ||
              videoUrl.toLowerCase().contains('onedrive');
          String? htmlData;

          if (isOneDrive) {
            String downloadUrl = videoUrl.contains('?')
                ? '${videoUrl.split('?').first}?download=1'
                : '$videoUrl?download=1';

            htmlData =
                '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <style>
    body { margin: 0; padding: 0; background-color: black; display: flex; justify-content: center; align-items: center; height: 100vh; overflow: hidden; }
    video { width: 100%; max-height: 100vh; outline: none; }
  </style>
</head>
<body>
  <video controls playsinline webkit-playsinline autoplay controlsList="nodownload noremoteplayback" disablePictureInPicture disableRemotePlayback x-webkit-airplay="deny">
    <source src="$downloadUrl" type="video/mp4">
  </video>
  <script>
    document.addEventListener('contextmenu', event => event.preventDefault());
  </script>
</body>
</html>
            ''';
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
                      initialUrlRequest: URLRequest(
                        url: WebUri(
                          widget.lectureVideo.startsWith('http')
                              ? widget.lectureVideo
                              : 'https://drive.google.com/file/d/${widget.lectureVideo}/preview',
                        ),
                      ),
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
                          forMainFrameOnly: false, // ← KEY: injects into iframes too
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
                      },
                      onLoadError: (controller, url, code, message) {
                        setState(() => loading = false);
                        debugPrint('WebView load error ($code): $message');
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

              // Loading indicator
              if (loading)
                Positioned.fill(
                  child: Center(
                    child: const CircularProgressIndicator(color: Colors.red),
                  ),
                ),

              // Black overlay to cover OneDrive/Google Drive top bar buttons
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(height: 48, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }
}
