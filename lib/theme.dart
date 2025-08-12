import 'package:flutter/material.dart';

const mainAccentColor = Color(0xff6446ff);
const paleAccentColor = Color(0xffBFC6FA);
const subAccentColor = Color(0xff5293FF);
const red900 = Color(0xffFF402F);
const red600 = Color(0xffFF6450);
const gray900 = Color(0xff1B1D1F);
const gray600 = Color(0xff454C53);
const gray400 = Color(0xff878EA1);
const gray200 = Color(0xffC9CDD2);
const gray100 = Color(0xffE8EBED);
const background = Color(0xffEDF3FB);

const pointEmphasis = Color(0xFFED5F5A);

const Color primaryColor = Color(0xFF000000);

ThemeData lightTheme = ThemeData(
  fontFamily: 'Pretendard',
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: Color(0xFFFFC107),
    // background: Color(0xFFFFFFFF),
    surface: Color(0xFFF5F5F5),
    error: Color.fromARGB(255, 202, 68, 95),
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    // onBackground: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,

    // 컬러 확장해야 함.
    // pointEmphasis: Color(0xFFED5F5A), // 강조 색상
  ),
  textTheme: TextTheme(
      // headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      // bodyText1: TextStyle(fontSize: 16),
      ),
  buttonTheme: ButtonThemeData(buttonColor: primaryColor),

  // 공통배경색야
  scaffoldBackgroundColor: Color(0xFFFFF5F5), // 앱 전역 배경색
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFF5F5),
    elevation: 0, // 그림자 제거
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color(0xFFFFF5F5),
  ),
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.amber,
    // background: Colors.black,
    surface: Colors.grey[800]!,
    error: Colors.redAccent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    // onBackground: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
  ),
);
