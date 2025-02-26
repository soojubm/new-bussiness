import 'package:flutter/material.dart';

// TODO
const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(4.0));

BorderSide defaultBorderSide(BuildContext context) {
  return BorderSide(
    color: Theme.of(context).primaryColor,
    width: 1,
  );
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: icon != null ? Icon(icon) : null,
          contentPadding: icon != null
              ? EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0)
              : EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
            borderSide: defaultBorderSide(context),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
            borderSide: defaultBorderSide(context),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
            borderSide: defaultBorderSide(context),
          ),
        ),
      ),
    );
  }
}
