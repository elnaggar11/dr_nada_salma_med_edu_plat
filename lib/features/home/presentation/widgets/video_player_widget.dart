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

  const VideoPlayerWidget({super.key, required this.lectureVideo, required this.courseId, required this.lectureId});

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
            padding: EdgeInsets.all(MediaQuery
                .of(context)
                .size
                .width / 70),
            margin: EdgeInsets.symmetric(horizontal: MediaQuery
                .of(context)
                .size
                .width / 40),
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
      body: Stack(
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
                    url: WebUri('https://drive.google.com/file/d/${widget.lectureVideo}/preview'),
                  ),
                  onWebViewCreated: (controller) => webView = controller,
                  onLoadStart: (controller, url) {
                    setState(() => loading = true);
                  },
                  onLoadStop: (controller, url) {
                    setState(() => loading = false);
                  },
                  onLoadError: (controller, url, code, message) {
                    setState(() => loading = false);
                    debugPrint('WebView load error ($code): $message');
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    if (!_shouldIgnoreConsoleMessage(consoleMessage.message)) {
                      debugPrint('WebView console: ${consoleMessage.message}');
                    }
                  },
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                      useOnLoadResource: true,
                      mediaPlaybackRequiresUserGesture: false,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Loading indicator
          if (loading)
            const CircularProgressIndicator(
              color: Colors.red,
            ),
        ],
      ),
    );
  }
}