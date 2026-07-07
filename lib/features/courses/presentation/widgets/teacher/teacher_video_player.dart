import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
          // Play Button Overlay
          Center(
            child: GestureDetector(
              onTap: () => _playInApp(context, videoUrl),
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFF06523), // Vibrant Orange
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
    var validUrl = url;
    if (!validUrl.startsWith('http://') && !validUrl.startsWith('https://')) {
      validUrl = 'https://$validUrl';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(validUrl)),
                onLoadStop: (controller, url) async {
                  // Inject CSS to hide Google Drive and OneDrive headers, buttons, and popouts
                  await controller.evaluateJavascript(source: '''
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
                  ''');
                },
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
