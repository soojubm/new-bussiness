import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final Function(Map<String, dynamic>)? onSubmit;
  final Alignment? alignment;
  final BoxConstraints? constraints;

  CustomForm({
    required this.formKey,
    required this.children,
    this.onSubmit,
    this.alignment = Alignment.center,
    this.constraints,
  });

  void _submitForm(GlobalKey<FormState> formKey) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      formKey.currentState?.save();
      if (onSubmit != null) {
        onSubmit!({});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      // TODO null-safety
      alignment: alignment!,
      child: Form(
        key: formKey,
        child: Container(
          constraints:
              constraints ?? BoxConstraints(maxWidth: 380, minHeight: 100),
          // padding: const EdgeInsets.all(gridMargin),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          // mainAxisAlignment: MainAxisAlignment.center,
          child: Column(
            spacing: 12,
            children: [
              ...children,
              SizedBox(height: 20),
              if (onSubmit != null)
                ElevatedButton(
                  onPressed: () => _submitForm(formKey),
                  child: Text('Submit'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
