import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../utils/colors.dart';
import '../widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _imageSelected;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUp() async {
    final _authMethods = Provider.of<AuthMethods>(context, listen: false);

    try {
      setState(() {
        _isLoading = true;
      });
      await _authMethods.signUpUser(
        _emailController.text,
        _passwordController.text,
        _usernameController.text,
        _bioController.text,
        _imageSelected!,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _imageSelected = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),

                    // Svg picture of Instagram
                    SvgPicture.asset(
                      'assets/images/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // Circle Avatar for images
                    Stack(
                      children: [
                        _imageSelected != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_imageSelected!),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.grey.shade800,
                                child: const Icon(
                                  Icons.person,
                                  size: 60,
                                ),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    // Username TextField
                    MyTextField(
                      controller: _usernameController,
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // Email TextField
                    MyTextField(
                      controller: _emailController,
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // Password TextField
                    MyTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.text,
                      obsureText: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // Bio textField
                    MyTextField(
                      controller: _bioController,
                      hintText: 'Enter your bio',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    // Login Button
                    InkWell(
                      onTap: signUp,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),

                    // toogle pages
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
