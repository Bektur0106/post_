import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:post/pages/qrcode.dart';
import 'UserObj.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late String email;
  late String pass;
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }
  static const backColor = Color(0xFFE3F2FD);
  static const primaryColor = Color(0xFF1E88E5);
  static const buttonColor = Color(0xFF0D47AD);

  Future<UserObj> authenticate(String username, String pwd ) async {
    final http.Response response = await http.post(
      Uri.parse('http://77.235.20.21:8087/api/Mobiles/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Username': username ?? "",
        'Password': pwd ?? ""
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
    return LayoutBuilder(builder: (context, constraints){
      return Container(
        alignment: Alignment.center,
        child: Scaffold(
          backgroundColor: backColor,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height*.99,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/IMG_20231014_084218.jpg'),
              //         fit: BoxFit.cover
              //     )
              // ),
              child:
              Padding(
                padding: constraints.maxWidth>1000&& constraints.maxHeight<1100?EdgeInsets.symmetric(horizontal: constraints.maxWidth/6): const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Flexible(flex:1,child: Padding(padding: EdgeInsets.only(top:60))),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     SizedBox(
                    //       child: Text(
                    //         'Привет',
                    //         style: TextStyle(
                    //           fontSize: 60,
                    //           color: Colors.white,
                    //
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Padding(padding: EdgeInsets.only(top:10)),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Text(
                              'Войдите в свой аккаунт',
                              style: TextStyle(
                                  fontSize: constraints.maxWidth>600 && constraints.maxHeight<900?constraints.maxWidth/25:constraints.maxWidth/15,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top:20)),
                    const Flexible(flex:3,child: Image(image: AssetImage('assets/—Pngtree—postman taking a letter_4404340.png'))), //width: constraints.maxWidth>500? constraints.maxWidth/2: constraints.maxWidth,)),
                    const Padding(padding: EdgeInsets.only(top:10)),
                    Container(
                      padding : const EdgeInsets.only(top: 10, bottom: 20,left: 5, right: 5),
                      margin: const EdgeInsets.fromLTRB(10, 20, 20,0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15
                              ),
                              onChanged: (String val){
                                email=val;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon: Icon(
                                    Icons.manage_accounts,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                      maxHeight: 20,
                                      minWidth: 40
                                  ),
                                  hintText: ' Имя пользователя',
                                  hintStyle: TextStyle(color: Colors.white,fontSize: 15)
                              ),
                            ),

                          ),
                          const Padding(padding: EdgeInsets.only(top:20)),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              keyboardType:TextInputType.visiblePassword,
                              obscureText:_obscured,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              onChanged: (String val){
                                pass=val;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(14),
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                    child: GestureDetector(
                                      onTap: _toggleObscured,
                                      child: Icon(
                                        _obscured
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                      maxHeight: 20,
                                      minWidth: 40
                                  ),
                                  hintText: 'Пароль',
                                  hintStyle: const TextStyle(color: Colors.white,fontSize: 15)
                              ),
                            ),
                            // padding: EdgeInsets.only(bottom:20),
                          ),
                          const Padding(padding: EdgeInsets.only(top:20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(padding: EdgeInsets.only(left:constraints.maxWidth/4)),
                              const Image(image: AssetImage('assets/postbox.png'), width: 60,height: 80,color: primaryColor,),
                              Padding(padding: EdgeInsets.only(left:constraints.maxWidth/10)),
                              SafeArea(
                                child: ElevatedButton(
                                  onPressed: (){
                                    //  if(email=='test' && pass=='test'){
                                    //     Navigator.restorablePushReplacementNamed(context, 'scan');
                                    //  }
                                    authenticate(email,pass).then((data) {
                                      //  print("Errer "+data.errorMessage??" ");
                                      if(data.isAuthSuccessful){
                                        var route= MaterialPageRoute(
                                          builder: (BuildContext context)=>
                                          QRscanner(otdelenieID: data.OtdelenieId),
                                        );
                                        Navigator.of(context).push(route);
                                      }
                                      else if(email=='' || pass=='' || email==pass && pass==''){
                                        const snackBar1 = SnackBar(
                                          closeIconColor: Colors.red,
                                          content: Text('Заполните все данные'),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                                      }
                                      else{
                                        const snackBar = SnackBar(
                                          closeIconColor: Colors.red,
                                          content: Text('Вы неправильно ввели свои данные'),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor
                                  ),
                                  child: const Text('Войти', style: TextStyle(color: Colors.white),),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}