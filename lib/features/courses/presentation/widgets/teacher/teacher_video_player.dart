import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      height: context.height / 3.5,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.width / 15),
          bottomRight: Radius.circular(context.width / 15),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(context.width / 15),
              bottomRight: Radius.circular(context.width / 15),
            ),
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
              onTap: () => _launchURL(videoUrl),
              child: Container(
                width: context.width / 6,
                height: context.width / 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6B35), // Primary Orange
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: context.width / 10,
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

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
