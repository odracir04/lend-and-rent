import 'package:app_prototype/widgets/login_button.dart';
import 'package:app_prototype/widgets/register_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(labelText: "Username:")
          ),
          TextFormField(
              decoration: const InputDecoration(labelText: "Password:"),
          ),
          const Row(
            children: [
              LoginButton(),
              RegisterButton(),
            ],
          )
        ],
      )
    );
  }

}
