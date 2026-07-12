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
  <video controls playsinline webkit-playsinline autoplay controlsList="nodownload">
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
                      onWebViewCreated: (controller) => webView = controller,
                      onLoadStart: (controller, url) {
                        setState(() => loading = true);
                      },
                      onLoadStop: (controller, url) async {
                        setState(() => loading = false);
                        // Inject CSS to hide Google Drive and OneDrive headers, buttons, and popouts
                        await controller.evaluateJavascript(
                          source: '''
                           var style = document.createElement('style');
                          style.innerHTML = `
                            /* === Hide ENTIRE top bar area for OneDrive === */
                            [class*="OneUp-header"],
                            [class*="OneUp-command"],
                            [class*="OneUp-close"],
                            [class*="OneUp-details"],
                            [class*="CommandBar"],
                            [class*="commandBar"],
                            [class*="od-TopBar"],
                            [class*="od-ItemHeader"],
                            [class*="od-OverflowMenu"],
                            [class*="od-Dialog-header"],
                            [class*="ms-CommandBar"],
                            [class*="Files-CommandBar"],
                            /* === Hide ENTIRE top bar for Google Drive === */
                            [class*="ndfHFb-c4YZDc-Wrql6b"],
                            [class*="ndfHFb-c4YZDc-GSQQnc"],
                            [class*="ndfHFb-c4YZDc-j7LFlb"],
                            [class*="ndfHFb-c4YZDc-to915"],
                            /* === Hide ALL buttons by aria-label === */
                            button[aria-label="Download"],
                            button[aria-label="Close"],
                            button[aria-label="Info"],
                            button[aria-label="Details"],
                            button[aria-label="View details"],
                            button[aria-label="Share"],
                            button[aria-label="More actions"],
                            button[aria-label="Open in new window"],
                            button[aria-label="إغلاق"],
                            button[aria-label="معلومات"],
                            button[aria-label="التفاصيل"],
                            button[aria-label="عرض التفاصيل"],
                            button[aria-label="مشاركة"],
                            button[aria-label="المزيد من الإجراءات"],
                            button[aria-label="تنزيل"],
                            button[aria-label="فتح في نافذة جديدة"],
                            /* === Hide by automationid === */
                            [data-automationid="closeButton"],
                            [data-automationid="moreActionsButton"],
                            [data-automationid="detailsPaneButton"],
                            [data-automationid="shareButton"],
                            [data-automationid="downloadButton"],
                            /* === Hide download links === */
                            a[download],
                            button[name="Download"] {
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
                          
                          // Prevent download from native HTML5 video controls
                          var videos = document.getElementsByTagName('video');
                          for(var i = 0; i < videos.length; i++) {
                            videos[i].setAttribute('controlsList', 'nodownload');
                            videos[i].setAttribute('disablePictureInPicture', 'true');
                            videos[i].setAttribute('disableRemotePlayback', 'true');
                            videos[i].setAttribute('x-webkit-airplay', 'deny');
                            // Also disable context menu on video elements specifically
                            videos[i].addEventListener('contextmenu', function(e) { e.preventDefault(); });
                          }
                          
                          // Disable context menu on the entire document
                          document.addEventListener('contextmenu', event => event.preventDefault());
                        ''',
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
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          userAgent:
                              "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1",
                          javaScriptEnabled: true,
                          useOnLoadResource: true,
                          mediaPlaybackRequiresUserGesture: false,
                          disableContextMenu:
                              true, // Prevents long press to save video
                          supportZoom:
                              false, // Prevents zooming out to see other elements
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
