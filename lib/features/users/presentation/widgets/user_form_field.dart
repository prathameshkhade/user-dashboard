import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      validator: (value) {
        if(value!.isEmpty) return '${widget.hint} is required';
        switch(widget.hint) {
          case 'Email': {
            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
              return 'Enter a valid email address';
            }
          }
          case 'Phone': {
            if(value.length < 10) return 'Phone number must be of 10 digits';
          }
          default: null;
        }
        return null;
      },
    );
  }
}