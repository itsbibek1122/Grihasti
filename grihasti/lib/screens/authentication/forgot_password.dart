import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/screens/authentication/components/authentication_appbar.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';
import 'package:grihasti/screens/authentication/components/my_textfield.dart';
import 'package:grihasti/utils/showSnackBar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? _email;

    void _submitForm() {
      if (_formKey.currentState?.validate() == true) {
        Future<void> passReset(BuildContext context) async {
          try {
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _email.toString());
          } on FirebaseAuthException catch (e) {
            mySnackBar(context, e.toString());
          }
        }
      }
    }

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: CustomAppBar()),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              'Forgot Password ?',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              "Don't Worry. It will only take few minutes.",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
            key: _formKey,
            child: MyTextField(
              hintText: 'Enter verification email here',
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: AuthenticationButton(
                text: 'Reset Password',
                onPressed: () {
                  _submitForm();
                }),
          )
        ],
      )),
    );
  }
}
