import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  static const primaryColor = Color(0xFF1E88E5);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
          padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('Статус вручения успешно установлен! ', style: TextStyle(
                    color: Colors.white,
                    fontSize:MediaQuery.of(context).size.width/23,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
