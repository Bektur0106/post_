import 'package:flutter/material.dart';
import 'package:post/pages/datadding.dart';
import 'package:post/pages/loginpage.dart';
import 'package:post/pages/newqpage.dart';
import 'package:post/pages/poluchatel.dart';
import 'package:post/pages/qrcode.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'log',
      routes: {
        'log' : (context)=> const LoginPage(),
        // DataAdd(res: 'ad', id: 555, otdelenie: 555, name: 'das', fam: 'ads', otch: 'fsdzfs'),
      },
    );
  }
}




