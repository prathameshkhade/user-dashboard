import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userdashboard/features/users/presentation/widgets/user_form_field.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // TextEditing Controllers
  final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'dob': TextEditingController(),
    'username': TextEditingController(),
    'password': TextEditingController(),
  };

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 25,
              children: <Widget>[
                // Full Name
                UserFormField(
                  controller: controllers['name']!,
                  hint: 'Full name',
                ),
                UserFormField(
                  controller: controllers['email']!,
                  hint: 'Email'
                ),
                UserFormField(
                  controller: controllers['phone']!,
                  hint: 'Phone'
                ),
                UserFormField(
                  controller: controllers['username']!,
                  hint: 'Username',
                ),
                UserFormField(
                  controller: controllers['password']!,
                  hint: 'Password',
                  isObsecure: true,
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CupertinoButton.filled(
            color: CupertinoColors.systemBlue,
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('User creating will be handled in future'))
                    );
              }
            },
            child: Text(
              'Create Account',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
