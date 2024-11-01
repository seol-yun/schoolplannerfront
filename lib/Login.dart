import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse("http://localhost:8080/api/auth/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": _idController.text,
        "pw": _pwController.text,
      }),
    );

    if (response.statusCode == 200) {
      print("로그인 성공!");
      // 로그인 성공 후 추가 처리 (예: 다음 페이지로 이동)
    } else {
      print("로그인 실패: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: '회원 ID'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _pwController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _login,
              child: Text("로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
