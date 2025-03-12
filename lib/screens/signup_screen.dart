import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _controller = TextEditingController();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      User? user = userCredential.user;

      // Firestore에 사용자 정보를 저장
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'username': username,
          'uid': user.uid,
          'profilePicture': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('가입완료링')),
      );
    } on FirebaseAuthException catch (e) {
      String feedbackMessage = '';

      if (e.code == 'weak-password') {
        feedbackMessage = '비밀번호 6자 이상부탁';
      } else if (e.code == 'email-already-in-use') {
        feedbackMessage = '이미 가입된 이메일이빈다요';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(feedbackMessage)),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // void _login() {
  //   String username = _controller.text; // TextField의 값 읽기
  //   print('Entered username: $username');

  //   if (_formKey.currentState?.validate() ?? false) {
  //     Navigator.pushNamed(context, '/home');
  //   } else {
  //     // 검증 실패 시 알림
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please fill in all fields correctly.')),
  //     );
  //   }
  // }

  // 공통 입력값 검증 함수
  String? commonValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter a $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(gridMargin),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 8,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    variant: 'secondary',
                    text: '구굴로시작하긔',
                    isFullWidth: true,
                    onPressed: signInWithGoogle,
                  ),

                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your email',
                    icon: Icons.email,
                    onChanged: (text) {
                      print('Entered text: $text');
                    },
                    validator: (value) => commonValidator(value, 'username'),
                  ),
                  // SizedBox 말고 TextFieldGroup
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your email',
                    onChanged: (text) {
                      print('Entered text: $text');
                    },
                    validator: (value) => commonValidator(value, 'password'),
                  ),

                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),

                  Column(spacing: 4.0, children: [
                    CustomButton(
                      variant: 'secondary',
                      text: '회원가입',
                      onPressed: _register,
                    ),
                  ]),

                  Text(_controller.text),
                ],
              ),
            )),
      ),
    );
  }
}

class NativePluginWidget extends StatefulWidget {
  const NativePluginWidget({super.key});

  @override
  State<NativePluginWidget> createState() => _NativePluginWidgetState();
}

class _NativePluginWidgetState extends State<NativePluginWidget> {
  XFile? _image;

  Future getGalleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              ElevatedButton(
                  onPressed: getGalleryImage, child: Text('gallery')),
              Center(
                child: _image == null
                    ? Text(
                        'No image selected',
                        style: TextStyle(color: Colors.white),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(_image!.path)),
                        radius: 100,
                      ),
              ),
              ElevatedButton(onPressed: getCameraImage, child: Text('camera')),
            ]),
          ),
        ),
      ),
    );
  }
}
