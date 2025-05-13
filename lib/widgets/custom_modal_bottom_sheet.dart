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
          CustomRow(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
            backgroundColor: Colors.green,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                variant: 'subhead',
                text: title,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          // const Divider(color: Colors.grey, thickness: 0.25),
          if (child != null) ...[
            child!,
          ],
        ],
      ),
    );
  }
}
