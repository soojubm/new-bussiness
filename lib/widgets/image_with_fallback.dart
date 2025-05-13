import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final String fallbackImageUrl;
  final String? loadingImageAsset; // 로딩 중 보여줄 로컬 이미지 (선택사항)

  const ImageWithFallback({
    Key? key,
    required this.imageUrl,
    required this.fallbackImageUrl,
    this.loadingImageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      imageUrl,
      placeholderBuilder: (context) {
        if (loadingImageAsset != null) {
          return Image.asset(loadingImageAsset!);
        }
        return const Center(child: CircularProgressIndicator());
      },
      height: 200,
      width: 200,
      fit: BoxFit.contain,
      semanticsLabel: 'SVG Image',
      clipBehavior: Clip.hardEdge,
      // 오류 발생 시 대체 이미지로 PNG나 다른 SVG 보여주기
      errorBuilder: (context, error, stackTrace) {
        return Image.network(fallbackImageUrl);
      },
    );
  }
}
