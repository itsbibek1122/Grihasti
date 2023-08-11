import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grihasti/screens/add_property/model/add_prop_textfield.dart';
import 'package:grihasti/screens/add_property/components/user_repository.dart';
import 'package:grihasti/screens/authentication/components/my_button.dart';
import 'package:grihasti/screens/authentication/components/my_textfield.dart';
import 'package:grihasti/screens/homescreen/components/custom_appbar.dart';
import 'package:grihasti/screens/homescreen/components/custom_drawer.dart';
import 'package:grihasti/screens/homescreen/components/editable_textfield.dart';
import 'package:grihasti/style/colors.dart';
import 'package:grihasti/utils/showSnackBar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      await _userRepository.fetchUserData();
      setState(() {});
    } catch (error) {
      // Handle error, show snackbar, or display an error message
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? userData = _userRepository.getUserData();
    return Scaffold(
        appBar: MyAppBar(title: 'Profile'),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1)),
                                ],
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/pic1.png'))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                  ),
                                  color: AppColors.orangeColor),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    EditableTextField(
                      initialValue: 'Tony Stark',
                      finalValue: 'Changed Name',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // EditableTextField(
                    //   initialValue: (_userData!['email']),
                    //   finalValue: 'Changed Email',
                    // ),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: (userData!['email']),
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    EditableTextField(
                      initialValue: (userData!['phonenumber']),
                      finalValue: 'Changed Phone',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    AuthenticationButton(text: 'Save', onPressed: () {})
                  ],
                )),
          ),
        ));
  }
}
