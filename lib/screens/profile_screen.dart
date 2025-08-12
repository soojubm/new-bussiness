import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/toekns_constants.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<List<String>> fetchProductIds() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('in_app_products').get();
    return querySnapshot.docs.map((doc) => doc['id'] as String).toList();
  }

  // Future<List<ProductDetails>> fetchProducts(List<String> productIds) async {
  //   final ProductDetailsResponse response =
  //       await InAppPurchase.instance.queryProductDetails(productIds.toSet());

  //   if (response.notFoundIDs.isNotEmpty) {
  //     print("찾을 수 없는 상품 ID: ${response.notFoundIDs}");
  //   }

  //   return response.productDetails;
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          // minWidth: 100,
          maxWidth: 380,
          minHeight: 100,
        ),
        padding: EdgeInsets.all(gridMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              // backgroundColor: Color,
              radius: 40.0,
              child: const Text('CJ', style: TextStyle(fontSize: 32)),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute<void>(
                //     builder: (BuildContext context) {
                //       return Scaffold()
                //     },
                //   ));
                // },
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("이 카드를 클릭하여 페이지 이동"),
                      SizedBox(height: 10),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute<void>(
                //     builder: (BuildContext context) {
                //       return Scaffold()
                //     },
                //   ));
                // },
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Delete()),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("회원 탈퇴"),
                      SizedBox(height: 10),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              '비로그인',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Image.asset('assets/images/food.png'),
            CustomButton(
                text: '로그아웃',
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut(); // 로그아웃
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("로그아웃 성공")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("로그아웃 오류: $e")),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Second Page"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 50, color: Colors.green),
            SizedBox(height: 10),
            Text("두 번째 페이지입니다."),
          ],
        ),
      ),
    );
  }
}

class Delete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "계정 삭제"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 50, color: Colors.green),
            SizedBox(height: 10),
            Text("회원 탈퇴 하기"),
          ],
        ),
      ),
    );
  }
}

class DeleteComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "계정 삭제"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 50, color: Colors.green),
            SizedBox(height: 10),
            Text("회원 탈퇴 하기"),
          ],
        ),
      ),
    );
  }
}
