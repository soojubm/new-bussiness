import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/widgets/custom_filled_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 텍스트 필드에서 입력된 값을 저장할 변수
  TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login() {
    // Form 검증
    if (_formKey.currentState?.validate() ?? false) {
      // 검증이 성공하면 홈 페이지로 이동
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
      body: Padding(
          padding: const EdgeInsets.all(gridMargin),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                  onChanged: (text) {
                    print(
                        'First text field: $text (${text.characters.length})');
                  },
                  validator: (value) => commonValidator(value, 'username'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true, // 비밀번호 입력 시 텍스트 숨기기
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => commonValidator(value, 'password'),
                ),
                SizedBox(height: 20),
                CustomFilledButton(
                  text: '로그인',
                  onPressed: _login,
                ),
              ],
            ),
          )),
    );
  }
}
