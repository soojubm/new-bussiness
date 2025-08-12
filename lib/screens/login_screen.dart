import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/custom_checkbox.dart';
import 'package:flutter_application_1/widgets/custom_column.dart';
import 'package:flutter_application_1/widgets/custom_form.dart';
import 'package:flutter_application_1/widgets/custom_modal_bottom_sheet.dart';
import 'package:flutter_application_1/widgets/custom_text.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key}); // super.key 추가

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  // 로그인 성공 후 사용자 정보를 저장할 변수 추가
  User? _currentUser;

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'], // 최소한의 정보만 요청
  );
  User? _user; // 현재 로그인된 사용자 정보

  Future<void> _signInWithGoogle() async {
    try {
      // Google 계정 선택 및 로그인
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // 사용자가 로그인 취소
        return;
      }

      // GoogleSignInAuthentication 객체 가져오기
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Firebase 자격 증명 생성
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase에 로그인
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      setState(() {
        _user = userCredential.user;
      });

      print("Signed in with Google: ${_user?.displayName}");

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print("Google sign-in error: $e");
    }
  }

  // 체크박스 상태 변수들
  bool _termsChecked = false;
  bool _privacyChecked = false;
  bool _marketingChecked = false;

  @override
  void initState() {
    super.initState();
    // 화면이 마운트된 후, 즉시 BottomSheet를 자동으로 열도록 설정
    // 프레임이 끝난 후 약간의 딜레이를 두고 실행하면 확실하게 트리거됨
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        _openBottomSheet();
      });
    });
  }

  // BottomSheet를 여는 함수
  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Sheet의 높이를 내용에 따라 조절할 수 있도록 설정
      builder: (BuildContext context) {
        // StatefulBuilder를 사용하여 BottomSheet 내부의 상태를 관리
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter modalSetState) {
            return Container(
              width: double.infinity,
              // height: 340, // height를 고정하기보다 내용에 맞추는 것이 좋습니다.
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                mainAxisSize: MainAxisSize.min, // Column의 높이를 내용에 맞춤
                children: [
                  CustomText(variant: 'title', text: '서비스 이용을 위해\n동의가 필요해요'),
                  SizedBox(height: 24),
                  CustomCheckbox(
                    value: _termsChecked,
                    onChanged: (newValue) {
                      // modalSetState를 사용하여 BottomSheet 내부만 리빌드
                      modalSetState(() {
                        _termsChecked = newValue;
                      });
                    },
                    label: '[필수] 서비스 이용약관',
                  ),
                  CustomCheckbox(
                    value: _privacyChecked,
                    onChanged: (newValue) {
                      // modalSetState를 사용하여 BottomSheet 내부만 리빌드
                      modalSetState(() {
                        _privacyChecked = newValue;
                      });
                    },
                    label: '[필수] 개인정보 처리방침',
                  ),
                  CustomCheckbox(
                    value: _marketingChecked,
                    onChanged: (newValue) {
                      // modalSetState를 사용하여 BottomSheet 내부만 리빌드
                      modalSetState(() {
                        _marketingChecked = newValue;
                      });
                    },
                    label: '[선택] 마케팅 정보 수신 동의',
                  ),
                  SizedBox(height: 24), // 버튼 위 여백 추가
                  CustomButton(
                    variant: 'secondary',
                    size: 'large',
                    isFullWidth: true,
                    text: '동의하고 시작하기',
                    onPressed: () {
                      // 필수 약관 동의 여부 확인
                      if (_termsChecked && _privacyChecked) {
                        Navigator.pop(context); // BottomSheet 닫기
                        // 여기에 동의 후 로그인 화면으로 이동하는 로직 등을 추가할 수 있습니다.
                      } else {
                        // 필수 약관에 동의하지 않았을 경우 사용자에게 알림
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('필수 약관에 모두 동의해야 합니다.'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login Page',
      ),
      body: SingleChildScrollView(
        child: CustomForm(
          formKey: _formKey,
          children: [
            CustomText(variant: 'title', text: '시작해볼까요?'),
            CustomText(
                variant: 'label-large', text: '로그인하고 AI와 함께 상세페이지를 만들어요!'),
            SizedBox(height: 40),

            if (_user != null)
              Column(
                children: [
                  Text("Welcome, ${_user!.displayName}"),
                  Text("Email: ${_user!.email}"),
                  // ElevatedButton(
                  //   onPressed: _signOut,
                  //   child: Text("Sign Out"),
                  // ),
                ],
              ),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _signInWithGoogle();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.white), // 버튼 색상
                  foregroundColor:
                      MaterialStateProperty.all(Colors.black), // 텍스트 색상
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 20)), // 패딩
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFFD1D1D1), width: 1),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    CustomText(variant: 'label-large', text: 'Apple로 로그인'),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _signInWithGoogle();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.white), // 버튼 색상
                  foregroundColor:
                      MaterialStateProperty.all(Colors.black), // 텍스트 색상
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50, vertical: 20)), // 패딩
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFFD1D1D1), width: 1),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    CustomText(variant: 'label-large', text: 'Google로 로그인'),
                  ],
                ),
              ),
            ),
            // 주석 처리된 부분 (이메일/비밀번호 로그인)은 그대로 유지했습니다.
            // const Divider(
            //     height: 20,
            //     thickness: .05,
            //     indent: 0,
            //     endIndent: 0,
            //     color: Colors.black),
            // CustomTextField(
            //   controller: _usernameController,
            //   labelText: 'Username',
            //   hintText: 'Enter your email',
            //   icon: Icons.email,
            //   onChanged: (text) {
            //     print('Entered text: $text');
            //   },
            //   validator: (value) => commonValidator(value, 'username'),
            // ),
            // // SizedBox 말고 TextFieldGroup
            // CustomTextField(
            //   controller: _passwordController,
            //   labelText: 'Password',
            //   hintText: 'Enter your email',
            //   onChanged: (text) {
            //     print('Entered text: $text');
            //   },
            //   validator: (value) => commonValidator(value, 'password'),
            // ),

            // if (errorMessage.isNotEmpty)
            //   Text(
            //     errorMessage,
            //     style: TextStyle(color: Colors.red),
            //   ),
            // CustomButton(
            //   variant: 'secondary',
            //   text: '로그인',
            //   onPressed: _login,
            //   isFullWidth: true,
            // ),
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
      body: CustomColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.indigo,
        children: (<Widget>[
          ElevatedButton(onPressed: getGalleryImage, child: Text('gallery')),
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
    );
  }
}
