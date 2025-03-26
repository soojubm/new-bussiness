import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_form.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  void _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (_formKey.currentState?.validate() ?? false) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: username, password: password);

        // Navigator.pushNamed(context, '/');
        // Navigator.pushReplacementNamed(context, '/')

        // currentUser가 null이 될 수 있는 이유는 2가지입니다.
        // 사용자가 로그인하지 않았습니다.
        // 인증 객체의 초기화가 완료되지 않았습니다.
        // 리스너를 사용해 사용자의 로그인 상태를 추적하면 이러한 상황을 처리할 필요가 없습니다.
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            print(user.uid);
          }
        });
      } on FirebaseAuthException catch (e) {
        // 오류 처리
        String newErrorMessage = '';
        if (e.code == 'invalid-email') {
          newErrorMessage = '이메일 양식이 아닙니다.';
        } else {
          newErrorMessage = '이메일 또는 비밀번호가 잘못 되었습니다.';
        }

        setState(() {
          errorMessage = newErrorMessage;
        });
      } catch (e) {
        // 일반적인 오류 처리
        print("General error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Something went wrong. Please try again later.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly.')),
      );
    }
  }

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
        // 유저가 있으면?
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
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: 'Login Page',
      ),
      body: SingleChildScrollView(
        child: CustomForm(
          formKey: _formKey,
          children: [
            CustomButton(
              variant: 'secondary',
              text: '구굴로시작하긔',
              onPressed: signInWithGoogle,
              isFullWidth: true,
            ),
            const Divider(
                height: 20,
                thickness: .05,
                indent: 0,
                endIndent: 0,
                color: Colors.black),
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
            CustomButton(
              variant: 'secondary',
              text: '로그인',
              onPressed: _login,
              isFullWidth: true,
            ),
          ],
        ),
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
      appBar: CustomAppBar(
        title: 'Image Picker',
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
