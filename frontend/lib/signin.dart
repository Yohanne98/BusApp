import 'dart:convert';

// import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/user.dart';
// import 'package:get_ip_address/get_ip_address.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/signup.dart';
import 'package:frontend/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

const storage = FlutterSecureStorage();

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    //String ipAddress = "192.168.1.5";

    var res = await http.post(Uri.parse("http://localhost:8080/signin"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': user.email,
          'password': user.password
        });
    String ans = res.body.toString();
    debugPrint(res.body);
    debugPrint(ans);
    if (ans == '' || ans == 'null') {
      Alert(
              context: context,
              title: "Error",
              desc: "Email or password does not match")
          .show();
    } else if (res.statusCode == 200) {
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        //debugPrint(body["_id"]);
        final id = body["_id"];
        debugPrint("Login token $id");

        
        await storage.write(key: "email", value: body["email"]);
        await storage.write(key: "password", value: body["password"]);


        //pageRoute(id);
        final pref = await SharedPreferences.getInstance();
        await pref.setString("Login", id);
        debugPrint(pref.getString("Login")!);
      }
    }

    debugPrint(res.statusCode.toString());
  }

  void pageRoute(String id) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("Login", id);
    debugPrint(pref.getString("Login")!);
  }

  Future<void> _readFromStorage() async{
    user.email = (await storage.read(key: "email"))!;
    user.password = (await storage.read(key: "password"))!;
  }

  @override
  void initState() {
    super.initState();
    _readFromStorage();
  }
 
  //check if the user is already logged in
  // void checkLogin() async {
  //   final pref = await SharedPreferences.getInstance();
  //   String? val = pref.getString("Login");
  //   if (val != null) {
  //      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Dashboard()), (route) => false);
  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Dashboard()),);
      
  //   }
  // }

  User user = User('', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 0,
            child: SvgPicture.asset(
              'images/top.svg',
              height: 100,
            )),
        Container(
          alignment: Alignment.center,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Signin',
                    style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.email),
                      onChanged: (value) {
                        user.email = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter field';
                        } else if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return null;
                        } else {
                          return 'Enter valid email';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(16)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(16)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      onChanged: (value) {
                        user.password = value;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter field';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(16)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(16)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50,0,50,0),
                    child: SizedBox(
                      height: 50,
                      width: 400,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              debugPrint('Ok');
                              save().then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Dashboard()),
                                  ));
                            } else {
                              debugPrint('Not okay');
                            }
                          },
                          child: const Text(
                            "Signin",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                      child: Row(
                        children: [
                          const Text(
                            "Not have Account ? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()));
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
