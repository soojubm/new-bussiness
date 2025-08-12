import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWithFallback extends StatelessWidget {
  final String imageUrl; // 실제로는 assetPath
  final String fallbackImageUrl;
  final String? loadingImageAsset;

  const ImageWithFallback({
    Key? key,
    required this.imageUrl,
    required this.fallbackImageUrl,
    this.loadingImageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return SvgPicture.asset(
        imageUrl, // 👉 로컬 asset SVG
        height: 200,
        width: 200,
        fit: BoxFit.contain,
        semanticsLabel: 'SVG Image',
        clipBehavior: Clip.hardEdge,
      );
    } catch (e) {
      // 에러 발생 시 fallback
      return Image.asset(fallbackImageUrl);
    }
  }
}
