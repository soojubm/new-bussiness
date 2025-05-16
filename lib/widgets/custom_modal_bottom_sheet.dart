import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_row.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final String title;
  final Widget? child;
  final double height;

  CustomModalBottomSheet({
    required this.title,
    this.child,
    this.height = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: CustomText(
                    variant: 'h5',
                    text: title,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          if (child != null) ...[
            child!,
          ],
        ],
      ),
    );
  }
}
