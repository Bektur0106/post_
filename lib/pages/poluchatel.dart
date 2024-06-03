import 'package:flutter/material.dart';
import 'package:post/pages/datadding.dart';

class Poluch extends StatefulWidget {
  final String? res;
  final int? id;
  final int? otdelenieId;
  final String? lastName;
  final String? firstName;
  final String? patName;
  final String? username;

  const Poluch({Key? key, required this.res, required this.id, required this.otdelenieId,required this.lastName,required this.firstName, required this.patName, required this.username})
      : super(key: key);
  @override
  State<Poluch> createState() => _PoluchState(res, id, otdelenieId, lastName,firstName,patName, username);
}

class _PoluchState extends State<Poluch> {
  String? result;
  int? id;
  int? otdelen;
  String? last;
  String? first;
  String? pat;
  String? usname;
  _PoluchState(this.result, this.id, this.otdelen, this.last,this.first, this.pat, this.usname);

  static const backColor = Color(0xFF90CAF9);
  static const primaryColor = Color(0xFF1E88E5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Получатель :',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DataAdd(res: result, id: id, otdelenie: otdelen,fam: last,name: first,otch: pat, usname: usname,),
                  );
                  Navigator.of(context).push(route);
                },
                child: const Text(
                  'Лично',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  var route = MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DataAdd(res: result, id: id, otdelenie: otdelen,fam: '',name: '',otch: '', usname: usname,),
                  );
                  Navigator.of(context).push(route);
                },
                child: const Text(
                  'Доверенное лицо',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
