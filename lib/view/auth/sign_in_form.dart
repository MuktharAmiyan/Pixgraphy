import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import '../../state/auth/notifier/auth_state_notifier.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _emailConteroller = TextEditingController();
  final _passwordConteroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailConteroller.dispose();
    _passwordConteroller.dispose();
  }

  String? _validateEmail(String? input) {
    if (RegExp(Strings.emailRegExp).hasMatch(input!)) {
      return null;
    }
    return Strings.invaliedEmail;
  }

  String? _validatePassword(String? input) {
    if (input!.length >= 6) {
      return null;
    }
    return Strings.shortPassword;
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      ref.read(authStateProvider.notifier).signInWithEmail(
            email: _emailConteroller.text.trim(),
            password: _passwordConteroller.text.trim(),
          );
    }
  }

  void _onChangeValidate(String input) {
    if (input.length >= 5) {
      _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailConteroller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: Strings.email,
            ),
            validator: _validateEmail,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordConteroller,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: Strings.password,
            ),
            validator: _validatePassword,
            onChanged: _onChangeValidate,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: _signIn,
            child: const Text(
              Strings.signIn,
            ),
          ),
        ],
      ),
    );
  }
}
