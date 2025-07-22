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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
        ),
      ),

      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CupertinoButton.filled(
            color: CupertinoColors.systemBlue,
            onPressed: () {},
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
