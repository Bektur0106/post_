import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:post/pages/UserObj.dart';
import 'package:post/pages/poluchatel.dart';

class QRscanner extends StatefulWidget {

  final int? otdelenieID;

  const QRscanner({Key? key, required this.otdelenieID}) : super(key: key);

  @override
  State<QRscanner> createState() => _QRscannerState(otdelenieID);
}

class _QRscannerState extends State<QRscanner> {

  int? otdelen;
  static const backColor = Color(0xFF90CAF9);
  static const primaryColor = Color(0xFF1E88E5);
  static const buttonColor = Color(0xFFC62828);

  _QRscannerState(this.otdelen);

  String? result;

  Future<UserObj> authenticate(String? barcode ) async {
    final http.Response response = await http.post(
      Uri.parse('http://77.235.20.21:8087/api/Mobiles/CheckItems'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Name': barcode ?? "",
        'OtdelenieId':otdelen.toString(),
      }),
    );
    print("Results: "+response.body);
    return UserObj.fromJson(json.decode(response.body));
    // final tt=TokenObj(IsAuthSuccessful: false,errorMessage: "test",Token: "test");

    // tt.IsAuthSuccessful=body['IsAuthSuccessful'];
    //print("Rets: "+body['errorMessage']);
    // return json.decode(response.body);

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Сканирование',style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: ()=> Navigator.pushNamed(context, 'log'),
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*.94,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/cyan.jpg'),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                        width: 350,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                          ),
                          onChanged: (String val){
                            result=val;
                          },
                          decoration: InputDecoration(
                              labelText: 'Штрих-код',
                              labelStyle: TextStyle(
                                color: primaryColor
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(width: 2, color: primaryColor)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: backColor)
                              )
                          ),
                        )
                    ),
                    Padding(padding: EdgeInsets.only(top:30)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0)
                              ),
                              height: 40,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: (){
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  authenticate(result).then((data) {
                                    if (data.isAuthSuccessful){
                                      var route= new MaterialPageRoute(
                                        builder: (BuildContext context)=>
                                        new Poluch(res: result,id:data.ItemId, otdelenieId: otdelen,firstName: data.Name,lastName: data.LastName,patName: data.PatronomycName,),
                                      );
                                      Navigator.of(context).push(route);
                                    }else{
                                      final snackBar = SnackBar(
                                        closeIconColor: Colors.red,
                                        content: Text(data.Name??"Ошибка"),
                                        duration: Duration(seconds: 5),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                },
                                child: Text('Проверить', style: TextStyle(fontSize: MediaQuery.of(context).size.width/23.058, color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,

                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top:450)),
                        Container(
                          width: 350,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SimpleBarcodeScannerPage(),
                                  )
                              );
                              setState(() {
                                if (res is String) {
                                  result = res;
                                }
                              });
                              setState(() {
                                if(result!='-1' && result!=''){
                                  authenticate(result).then((data) {
                                    if (data.isAuthSuccessful){
                                      var route= new MaterialPageRoute(
                                        builder: (BuildContext context)=>
                                        new Poluch(res: result,id:data.ItemId, otdelenieId: otdelen,firstName: data.Name,lastName: data.LastName,patName: data.PatronomycName,),
                                      );
                                      Navigator.of(context).push(route);
                                    }else{
                                      final snackBar = SnackBar(
                                        closeIconColor: Colors.red,
                                        content: Text(data.Name??"Ошибка"),
                                        duration: Duration(seconds: 5),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                }
                              });
                            },
                            icon: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                            label: Text(
                              'Начать сканирование',
                              style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width/22),
                            ),
                          ),
                        ),
                        // Padding(padding: EdgeInsets.only(top:70)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
