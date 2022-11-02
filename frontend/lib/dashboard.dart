import 'package:flutter/material.dart';
import 'package:frontend/Home.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listJournies.dart';





class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String id = "";
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    journies(),
    Text(
      'Index 2: School',
      //style: optionStyle,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
    
  }

  //get values from shared perf
  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("Login")!;
    });
    debugPrint(id);
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  int currentIndex = 0;

  final tabs = [
    const Home(),
    const Center(child: Text("price"),),
    const Center(child: Text("profile"),),
  ];

  @override
  Widget build(BuildContext context) {

    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    

    return SizedBox(
      // height: height,
      // width: width,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Center(
          child: _widgetOptions.elementAt(currentIndex),
          
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet ),
              label: 'Credit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
