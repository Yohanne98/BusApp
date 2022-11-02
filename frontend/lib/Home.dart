import 'package:flutter/material.dart';
import 'package:frontend/journey.dart';
import 'package:frontend/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

User user = User('', '');
//Journey journey = Journey('', '', '', '', '');

class _HomeState extends State<Home> {
  String ipAddress = "192.168.1.5";
  //final _formKey = GlobalKey<FormState>();

  var locationMessage = "";
  var fare = 0.0;
  var distance = 0.0;

  void getCurrentLocation() async {
    // var position = await Geolocator().
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var lastPostion = await Geolocator.getLastKnownPosition();
    debugPrint("postitinn: $lastPostion");

    var positionAlt = position.altitude;
    var positionLong = position.longitude;
    debugPrint("$positionAlt");

    setState(() {
      locationMessage = "$positionAlt , $positionLong";
    });
  }

  void getFare() async {
    var distance = 5.0;
    var totalfare = distance * 30.0;
    var farenew = fare.toString();

    debugPrint(farenew);

    setState(() {
      fare = totalfare;
    });
  }

  Future save() async {
    //String ipAddress = "192.168.1.5";

    var res = await http.post(Uri.parse("http://localhost:8080/:id/reviews"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'from': journey.from,
          'to': journey.to,
          'distance': "20",
          'fare': "150",
        });
    // String ans = res.body.toString();
    // debugPrint(res.body);
    // debugPrint(ans);
    // if (ans == '' || ans == 'null') {
    //   Alert(
    //           context: context,
    //           title: "Error",
    //           desc: "Email or password does not match")
    //       .show();
    // } else if (res.statusCode == 200) {
    //   if (res.statusCode == 200) {
    //     final body = jsonDecode(res.body);
    //     //debugPrint(body["_id"]);
    //     final id = body["_id"];
    //     debugPrint("Login token $id");

        
    //     await storage.write(key: "email", value: body["email"]);
    //     await storage.write(key: "password", value: body["password"]);


    //     //pageRoute(id);
    //     final pref = await SharedPreferences.getInstance();
    //     await pref.setString("Login", id);
    //     debugPrint(pref.getString("Login")!);
    //   }
    // }

    debugPrint(res.statusCode.toString());
  }

  Journey journey = Journey('', '','','','');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: TextEditingController(text: journey.from),
              onChanged: (value) {
                journey.from = value;
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter field';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Current location",
              ),
            ),
          ),
          Text("Position: $locationMessage"),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                    getCurrentLocation();
                  },
                  child: const Text(
                    "Get current location",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: TextEditingController(text: journey.to),
              onChanged: (value) {
                journey.to = value;
              },
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter field';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "destination",
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                  ),
                  onPressed: () {
                    getFare();
                  },
                  child: const Text(
                    "Get total fare",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
          Text("Total fare: $fare",
              style: const TextStyle(color: Colors.black, fontSize: 20)),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              height: 50,
              width: 200,
              child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                  ),
                  onPressed: () {
                    save();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),

          // Row(
          //   children: const <Widget>[

          //     Expanded(
          //       child:
          //           Text('Get current location', textAlign: TextAlign.center),
          //     ),
          //     Expanded(
          //       child: Icon(
          //         Icons.location_on,
          //         size: 26.0,
          //         color: Colors.blue,
          //       ),
          //     ),
          //     Expanded(
          //       child: Home(),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
