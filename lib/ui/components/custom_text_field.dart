// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final IconData? prefix;
  final String? Function(String?)? validator;
  final IconButton? suffix;
  final int? maxlines;
  final bool obscureText;
  final String? initialValue;
  final bool? enabled;
  final Function(String?)? onChanged;
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefix,
    this.validator,
    this.suffix,
    this.maxlines = 1,
    this.obscureText = false,
    this.initialValue,
    this.enabled,
    this.onChanged,
  }) : super(key: key);
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: widget.obscureText,
      controller: widget.controller,
      maxLines: widget.maxlines,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        labelText: widget.labelText,
        fillColor: Colors.grey[100],
        focusColor: Colors.white,
        hintText: widget.hintText,
        labelStyle: const TextStyle(
          fontSize: 16.0,
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefix != null ? Icon(widget.prefix) : null,
      ),
    );
  }
}
