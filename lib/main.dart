import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Team5 Frisbee'),
        ),
        body: CenteredButton(),
      ),
    );
  }
}

class CenteredButton extends StatefulWidget {
  @override
  _CenteredButtonState createState() => _CenteredButtonState();
}

class _CenteredButtonState extends State<CenteredButton> {
  String _responseText = '';

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse(
        'https://project6-168ik-default-rtdb.firebaseio.com/users.json?auth=AIzaSyBNKX23903F-vUtzV9JS9Ez6KVutINAGug'));
    if (response.statusCode == 200) {
      var s = jsonDecode(response.body);
      var A = (s["-NUuuO5NA7RrAcYkGQwd"]).toString();
      A = A.replaceAll(new RegExp(r'{'), '');
      A = A.replaceAll(new RegExp(r'null'), '');
      A = A.replaceAll(new RegExp(r'}'), '');
      // var B = (s["-NUvI2EeoRboeH2CQB2F"]).toString();
      // B = B.replaceAll(new RegExp(r'{'), '');
      // B = B.replaceAll(new RegExp(r'}'), '');
      setState(() {
        _responseText = _responseText + A;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _fetchData,
          child: Text('Fetch Acc Data'),
          style: ElevatedButton.styleFrom(
            primary: Color(0xd2102552),
            onPrimary: Colors.white,
            textStyle: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
        Text(
          _responseText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
