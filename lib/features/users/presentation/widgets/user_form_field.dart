import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObsecure;

  const UserFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.isObsecure = false,
  });

  @override
  State<UserFormField> createState() => _UserFormFieldState();
}

class _UserFormFieldState extends State<UserFormField> {
  bool isPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.hint,
        counterText: '',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.all(18),
        suffixIcon: widget.isObsecure
            ? IconButton(
          onPressed: () => setState(() => isPassVisible = !isPassVisible),
          icon: Icon(
            isPassVisible ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
            color: Colors.grey,
          ),
        )
            : null,
      ),
      obscureText: widget.isObsecure && !isPassVisible,
      keyboardType: switch (widget.hint) {
        'Full name' => TextInputType.name,
        'Email' => TextInputType.emailAddress,
        'Phone' => TextInputType.phone,
        'Password' => TextInputType.visiblePassword,
        _ => TextInputType.text,
      },
      maxLength: widget.hint.toLowerCase().contains('phone') ? 10 : 40,
    );
  }
}