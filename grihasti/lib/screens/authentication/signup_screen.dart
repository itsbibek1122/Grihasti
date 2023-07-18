import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/provider/auth_provider.dart';
import 'package:grihasti/provider/sign_up_auth.dart';
import 'package:grihasti/screens/authentication/components/authentication_appbar.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';
import 'package:grihasti/screens/authentication/components/my_textfield.dart';
import 'package:grihasti/screens/authentication/components/psw_textfield.dart';
import 'package:grihasti/services/auth_service.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Future<void> _signUp() async {
  //   try {
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text,
  //     );
  //     // Reset form fields
  //     _nameController.clear();
  //     _phoneController.clear();
  //     _emailController.clear();
  //     _passwordController.clear();
  //     // Navigate to the home screen or perform other actions after successful sign-up.
  //   } catch (e) {
  //     // Handle sign-up errors (e.g., display an error message).
  //     print('Error: $e');
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneController.text,
      context: context,
      name: nameController.text,
    );

    // void addUsersDetails(
    //     String fullname, String phonenumber, String email) async {
    //   await FirebaseFirestore.instance.collection('users').add({
    //     'fullname': fullname.toString(),
    //     'phonenumber': phonenumber.toString(),
    //     'email': email.toString(),
    //   });
    // }
  }

  // Future addUsersDetails(
  //     String fullname, String phonenumber, String email) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'fullname': fullname.toString(),
  //     'phonenumber': phonenumber.toString(),
  //     'email': email.toString(),
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: CustomAppBar()),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.house_rounded,
                    size: 80,
                  ),
                ),
                const SizedBox(height: 25),

                // welcome back, you've been missed!
                Text(
                  'Enter your credentials',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  hintText: 'Full Name',
                  controller: nameController,
                ),
                const SizedBox(height: 10),

                MyTextField(
                  hintText: 'Phone Number',
                  controller: phoneController,
                ),
                const SizedBox(height: 10),

                // username textfield
                MyTextField(
                  hintText: 'Email',
                  controller: emailController,
                ),

                const SizedBox(height: 10),

                // password textfield
                PasswordTextField(
                  hintText: 'Enter Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                PasswordTextField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                ),

                const SizedBox(height: 40),

                AuthenticationButton(
                    text: 'Sign Up',
                    onPressed: () {
                      if (passwordController.text !=
                              confirmPasswordController.text ||
                          phoneController == null ||
                          confirmPasswordController == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error Signing In')));
                      } else {
                        signUpUser();
                      }

                      // if (_formKey.currentState!.validate()) {
                      //   _signUp();
                      // }
                    })
              ],
            ),
          ),
        ));
  }
}
