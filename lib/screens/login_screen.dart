import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/widgets/custom_filled_button.dart';
import 'package:flutter_application_1/widgets/custom_icon_button.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 텍스트 필드에서 입력된 값을 저장할 변수
  TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/home');
    } else {
      // 검증 실패 시 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields correctly.')),
      );
    }
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
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(gridMargin),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: _controller,
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
                    controller: _controller,
                    labelText: 'Password',
                    hintText: 'Enter your email',
                    onChanged: (text) {
                      print('Entered text: $text');
                    },
                    validator: (value) => commonValidator(value, 'password'),
                  ),
                  CustomFilledButton(
                    text: '로그인',
                    onPressed: _login,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomIconButton(
                        icon: Icons.volume_up,
                        tooltip: "아이콘 버튼 스몰",
                        onPressed: () {
                          print('아이콘 버튼이 눌렸습니다!');
                        },
                        size: ButtonSize.small),
                    CustomIconButton(
                        icon: Icons.volume_up,
                        tooltip: "아이콘 버튼 미디엄",
                        onPressed: () {
                          print('아이콘 버튼이 눌렸습니다!');
                        }),
                  ]),
                  // Button to navigate to the NativePluginWidget page
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NativePluginWidget()),
                      );
                    },
                    child: Text('Open Image Picker'),
                  ),
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
