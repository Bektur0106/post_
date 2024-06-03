import 'package:flutter/material.dart';
import 'package:post/pages/qrcode.dart';

class NewPage extends StatefulWidget {

  final int? id;
  final String? usname;
  const NewPage({super.key, required this.id, required this.usname});

  @override
  State<NewPage> createState() => _NewPageState(id, usname);
}

class _NewPageState extends State<NewPage> {

  int? Otid;
  String? name;
  _NewPageState(this.Otid, this.name);
  Future<bool> _onWillPop() async {
    var route= MaterialPageRoute(
      builder: (BuildContext context)=>
          QRscanner(otdelenieID: Otid, name: name,),
    );
    Navigator.of(context).push(route);
    return true;
  }

  static const primaryColor = Color(0xFF1E88E5);
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(20),
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
        ),
        onWillPop: _onWillPop);
  }
}
