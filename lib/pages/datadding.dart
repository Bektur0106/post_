import 'dart:convert';
import 'package:post/pages/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:post/pages/UserObj.dart';
import 'package:post/pages/push.dart';


class DataAdd extends StatefulWidget {

  final String? res;
  final int? otdelenie;
  final int? id;
  final String? fam;
  final String? name;
  final String? otch;
  const DataAdd({Key? key, required this.res, required this.id,required this.otdelenie, required this.name, required this.fam, required this.otch}) : super(key: key);

  @override
  State<DataAdd> createState() => _DataAddState(res,id,otdelenie, name, fam, otch);
}

class _DataAddState extends State<DataAdd> {

  String? result;
  int? otdelen;
  int? id;
  String? name;
  String? famil;
  String? otch;
  static const backColor = Color(0xFFE3F2FD);
  static const primaryColor = Color(0xFF1E88E5);
  static const buttonColor = Color(0xFF0D47AD);
  _DataAddState(this.result,this.id, this.otdelen, this.name, this.famil, this.otch);
  Data data = Data(
      familiya: '',
      name: '',
      otchestvo: '',
      seriya: '',
      inn: '');

  Future<UserObj> postData(Data data) async {
    final http.Response response = await http.post(
      Uri.parse('http://77.235.20.21:8087/api/Mobiles/Vruchit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'LastName': data.familiya ?? "",
        'Name': data.name ?? "",
        'Otchestvo': data.otchestvo ?? "",
        'PIN': data.inn ?? "",
        'Passport': data.seriya ?? "",
        'Id':id.toString()
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return UserObj.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
  final control= TextEditingController();
  final control1= TextEditingController();
  final control2= TextEditingController();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    control.text=famil!;
    control1.text=name!;
    control2.text=otch!;
    return Container(
      child: Scaffold(
          backgroundColor: backColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Отправка отчета', style: TextStyle(color: Colors.white),),
            toolbarHeight: 60,
            leading: IconButton(
              onPressed: (){
                var route= MaterialPageRoute(
                  builder: (BuildContext context)=>
                  QRscanner(otdelenieID: otdelen),
                );
                Navigator.of(context).push(route);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: buttonColor,

          ),
          body:LayoutBuilder(builder: (context, constraints){
            return GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
                FocusScopeNode currentFocus = FocusScope.of(context);
                if(!currentFocus.hasPrimaryFocus){
                  currentFocus.unfocus();
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top:30)),
                        Padding(
                          padding: const EdgeInsets.only(left:30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    const Text('Товар: ', style:
                                    TextStyle(
                                        fontSize: 25,
                                        color: Colors.black87
                                    )
                                      ,),
                                    Text('$result', style:
                                    const TextStyle(
                                        fontSize: 20,
                                        color: primaryColor
                                    )
                                      ,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 17),
                          child: Container(
                            padding : const EdgeInsets.only(top: 10, bottom: 20,left: 5, right: 15),
                            margin: const EdgeInsets.fromLTRB(10, 30, 20,0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:3),
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    controller: control,
                                    // onChanged: (String val){
                                    //   data.familiya=val;
                                    // },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.manage_accounts, color: buttonColor,),
                                        focusedBorder:const OutlineInputBorder(
                                            borderSide: BorderSide(width: 2, color: buttonColor)
                                        ) ,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(width: 2, color: primaryColor)
                                        ),
                                        contentPadding: const EdgeInsets.all(20),
                                        labelText: 'Фамилия',
                                        labelStyle: const TextStyle(
                                            color: primaryColor
                                        )
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top:20)),
                                Padding(
                                  padding: const EdgeInsets.only(top:3),
                                  child: TextFormField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    controller: control1,
                                    // onChanged: (String val){
                                    //   data.name=val;
                                    // },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.man_3_rounded, color: buttonColor,),
                                        focusedBorder:const OutlineInputBorder(
                                            borderSide: BorderSide(width: 2, color: buttonColor)
                                        ) ,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                width: 2,
                                                color: primaryColor
                                            )
                                        ),
                                        contentPadding: const EdgeInsets.all(20),
                                        labelText: 'Имя',
                                        labelStyle: const TextStyle(
                                            color: primaryColor
                                        )
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top:20)),
                                Padding(
                                  padding: const EdgeInsets.only(top:3),
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),
                                    controller: control2,
                                    // onChanged: (String val){
                                    //   data.otchestvo=val;
                                    // },
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.manage_accounts_outlined, color: buttonColor,),
                                        focusedBorder:const OutlineInputBorder(
                                            borderSide: BorderSide(width: 2, color: buttonColor)
                                        ) ,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                                width: 2,
                                                color: primaryColor
                                            )
                                        ),
                                        contentPadding: const EdgeInsets.all(20),
                                        labelText: 'Отчество',
                                        labelStyle: const TextStyle(
                                            color: primaryColor
                                        )
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top:20)),
                                Padding(
                                  padding: const EdgeInsets.only(top:3),
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 18,
                                    ),
                                    onChanged: (String val){
                                      data.seriya=val;
                                    },
                                    // keyboardType: TextInputType.number,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp('[0-9-]')),
                                    // ],
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.account_box_rounded, color: buttonColor,),
                                      focusedBorder:const OutlineInputBorder(
                                          borderSide: BorderSide(width: 2, color: buttonColor)
                                      ) ,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              width: 2,
                                              color: primaryColor
                                          )
                                      ),
                                      contentPadding: const EdgeInsets.all(20),
                                      labelText: 'Серия паспорта',
                                      labelStyle: const TextStyle(
                                          color: primaryColor
                                      ),
                                      hintText: '',
                                      hintStyle: const TextStyle(color: Colors.black54,fontSize: 16),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top:20)),
                                Padding(
                                  padding: const EdgeInsets.only(top:3),
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 18,
                                    ),
                                    onChanged: (String val){
                                      data.inn=val;
                                    },
                                    // keyboardType: TextInputType.number,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   FilteringTextInputFormatter.allow(
                                    //       RegExp('[0-9-]')),
                                    // ],
                                    maxLength: 14,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      prefixIcon: const Icon(Icons.add, color: buttonColor,),
                                      focusedBorder:const OutlineInputBorder(
                                          borderSide: BorderSide(width: 2, color: buttonColor)
                                      ) ,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              width: 2,
                                              color: primaryColor
                                          )
                                      ),
                                      contentPadding: const EdgeInsets.all(20),
                                      labelText: 'ПИН',
                                      labelStyle: const TextStyle(
                                          color: primaryColor
                                      ),
                                      hintStyle: const TextStyle(color: Colors.black54,fontSize: 16),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top:40)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        data.familiya=control.text;
                                        data.name=control1.text;
                                        data.otchestvo=control2.text;
                                        postData(data).then((result) {
                                          validator (value) {
                                            final RegExp regex = RegExp('[0-9]');
                                            if (value == null || value.isEmpty || !regex.hasMatch(value)) {
                                              return false;
                                            }
                                            return true;
                                          };
                                          if (result.isAuthSuccessful && data.inn.length==14 && validator(data.inn) && validator(data.seriya)){
                                            Navigator.of(context).pushNamed('new');
                                          }
                                          else {
                                            final snackBar = SnackBar(
                                              closeIconColor: Colors.red,
                                              content: Text("Заполните все поля правильно"),
                                              duration: const Duration(seconds: 3),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor,
                                      ),
                                      child: SizedBox(
                                        width: constraints.maxWidth<400? 220:constraints.maxWidth<600? 260: constraints.maxWidth<1040 && constraints.maxWidth>=600? constraints.maxWidth/1.5: constraints.maxWidth/2.3,
                                        height: constraints.maxWidth<600? 50: constraints.maxWidth<1040 && constraints.maxWidth>=600? constraints.maxWidth/13: constraints.maxWidth/20,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('Отправить',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: constraints.maxWidth<600? 20: constraints.maxWidth<1040 && constraints.maxWidth>=600? constraints.maxWidth/37: constraints.maxWidth/50
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )]),
                ),
              ),
            );
    },))
    );
  }
}
