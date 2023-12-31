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
  static const backColor = Color(0xFFE3F2FD);
  static const primaryColor = Color(0xFF1E88E5);
  static const buttonColor = Color(0xFF0D47AD);

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
    print("Results: ${response.body}");
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
        title: const Text('Сканирование',style: TextStyle(color: Colors.white),),
        backgroundColor: buttonColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: ()=> Navigator.pushNamed(context, 'log'),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints){
        return GestureDetector(
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
              height: MediaQuery.of(context).size.height*.90,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/cyan.jpg'),
                      fit: BoxFit.cover
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30, top: 25),
                child: Column(
                  children: [
                    SizedBox(
                        width: constraints.maxWidth<600? 350: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/1.5: constraints.maxWidth/2.3,
                        height: constraints.maxWidth<600? 70: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/10: constraints.maxWidth/20,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxWidth<600? 20: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/30: constraints.maxWidth/40,

                          ),
                          onChanged: (String val){
                            result=val;
                          },
                          decoration: InputDecoration(
                              labelText: 'Штрих-код',
                              labelStyle: TextStyle(
                                  color: primaryColor,
                                fontSize: constraints.maxWidth<600? 20: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/30: constraints.maxWidth/40,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(width: 2, color: primaryColor)
                              ),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: backColor)
                              )
                          ),
                        )
                    ),
                    const Padding(padding: EdgeInsets.only(top:15)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth<600? 350: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/1.5: constraints.maxWidth/2.3,
                          height: constraints.maxWidth>600? constraints.maxWidth/18: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0)
                                ),
                                height: constraints.maxWidth<600? 40: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/18: constraints.maxWidth/25,
                                width: constraints.maxWidth<600? 160: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/4: constraints.maxWidth/7,
                                child: ElevatedButton(
                                  onPressed: (){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    authenticate(result).then((data) {
                                      if (data.isAuthSuccessful){
                                        var route= MaterialPageRoute(
                                          builder: (BuildContext context)=>
                                              Poluch(res: result,id:data.ItemId, otdelenieId: otdelen,firstName: data.Name,lastName: data.LastName,patName: data.PatronomycName,),
                                        );
                                        Navigator.of(context).push(route);
                                      }else{
                                        final snackBar = SnackBar(
                                          closeIconColor: Colors.red,
                                          content: Text(data.Name??"Ошибка"),
                                          duration: const Duration(seconds: 5),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,

                                  ),
                                  child: Text('Проверить', style: TextStyle(fontSize: constraints.maxWidth<600? 20: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/38: constraints.maxWidth/55, color: Colors.white),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top:constraints.maxHeight<650?constraints.maxHeight/2:constraints.maxWidth>1050?constraints.maxHeight/2.2:constraints.maxHeight/1.55)),
                        SizedBox(
                          width: constraints.maxWidth<600? 350: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/1.5: constraints.maxWidth/2.3,
                          height: constraints.maxWidth<600? 50: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/13: constraints.maxWidth/20,
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
                                      var route= MaterialPageRoute(
                                        builder: (BuildContext context)=>
                                            Poluch(res: result,id:data.ItemId, otdelenieId: otdelen,firstName: data.Name,lastName: data.LastName,patName: data.PatronomycName,),
                                      );
                                      Navigator.of(context).push(route);
                                    }else{
                                      final snackBar = SnackBar(
                                        closeIconColor: Colors.red,
                                        content: Text(data.Name??"Ошибка"),
                                        duration: const Duration(seconds: 5),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                }
                              });
                            },
                            icon: Icon(Icons.camera_alt_outlined, color: Colors.white,size: constraints.maxWidth>600? constraints.maxWidth/25: 30,),
                            label: Text(
                              'Начать сканирование',
                              style: TextStyle(color: Colors.white, fontSize: constraints.maxWidth<600? 20: constraints.maxWidth<1040 && constraints.maxWidth>600? constraints.maxWidth/37: constraints.maxWidth/50),
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
        );
      },)
    );
  }
}
