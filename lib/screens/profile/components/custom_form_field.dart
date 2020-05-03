import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final IconData icon;
  final String label;
  final String hint;
  final TextInputType inputType;
  final bool obscureText;
  final Function validator;
  final Function onSaved;

  const CustomFormField({
    this.icon,
    this.label,
    this.hint,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  });

  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        hintText: widget.hint,
        labelText: widget.label,
      ),
      keyboardType: widget.inputType,
      obscureText: widget.inputType == TextInputType.visiblePassword,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
