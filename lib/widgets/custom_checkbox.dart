import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: widget.value ? primaryColor : Colors.transparent,
          border: Border.all(
            color: widget.value ? primaryColor : Colors.grey,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                size: 18.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
