import 'dart:convert';
import 'package:post/pages/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:post/pages/qrcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Вы уверены?'),
        content: new Text('Хотите ли вы выйти из приложения?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Да'),
          ),
        ],
      ),
    )) ?? false;
  }

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


  final TextEditingController textController = TextEditingController();
  final TextEditingController passController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  Future init() async{
    final pref = await SharedPreferences.getInstance();
    final email_1 = await pref.getString('email')?? '';
    final pass_1 = await pref.getString('pass')?? '';
    print(email_1);
    setState(() {
      this.textController.text = email_1;
      this.passController.text = pass_1;
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return WillPopScope(
        child: LayoutBuilder(builder: (context, constraints){
          return Container(
            alignment: Alignment.center,
            child: Scaffold(
              backgroundColor: backColor,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Center(
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
                            child: AutofillGroup(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextField(
                                      controller: textController,
                                      autofillHints: [AutofillHints.username],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15
                                      ),
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
                                      controller: passController,
                                      autofillHints: [AutofillHints.password],
                                      keyboardType:TextInputType.visiblePassword,
                                      obscureText:_obscured,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
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
                                          onPressed: () async {
                                            final prefs = await SharedPreferences.getInstance();
                                            await prefs.setString('email', textController.text);
                                            await prefs.setString('pass', passController.text);
                                            TextInput.finishAutofillContext();
                                            // if(email=='test' && pass=='test'){
                                            //    Navigator.restorablePushReplacementNamed(context, 'scan');
                                            // }
                                            authenticate(textController.text,passController.text).then((data) {
                                              //  print("Errer "+data.errorMessage??" ");
                                              if(data.isAuthSuccessful){
                                                var route= MaterialPageRoute(
                                                  builder: (BuildContext context)=>
                                                      QRscanner(otdelenieID: data.OtdelenieId, name: data.Name),
                                                );
                                                Navigator.of(context).push(route);
                                              }
                                              else if(textController.text=='' || passController.text=='' || textController.text==passController.text && passController.text==''){
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
        onWillPop: _onWillPop);
  }
}