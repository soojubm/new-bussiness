import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String size; // small | medium
  final String imageUrl;
  // final Color borderColor;
  // final double borderWidth;

  CustomAvatar({
    required this.size,
    required this.imageUrl,
    // this.borderColor = Colors.white,
    // this.borderWidth = 2.0,
  });

  double _getSize() {
    switch (size) {
      case 'small':
        return 40.0;
      case 'medium':
        return 80.0;
      default:
        return 40.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double avatarSize = _getSize();

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(color: borderColor, width: borderWidth),
        border: Border.all(color: Colors.grey, width: 1.0),
        boxShadow: [],
      ),
      child: ClipOval(
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: avatarSize,
                height: avatarSize,
              )
            : Container(
                color: Colors.grey[300],
                width: avatarSize,
                height: avatarSize,
                child: Center(
                  child: Text(
                    'No Image', // 이미지가 없을 때의 텍스트
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}
