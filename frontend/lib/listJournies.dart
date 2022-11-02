import 'package:flutter/material.dart';
import 'package:frontend/journey.dart';
import 'package:frontend/journey2.dart';

class journies extends StatefulWidget {
  const journies({super.key});

  @override
  State<journies> createState() => _journiesState();
}

class _journiesState extends State<journies> {
  List<Journey2> journies = [
    Journey2(
        from: "Rukamlgama",
        to: "Kottawa",
        distance: "10",
        fare: "150.00",
        date: '2022-11-2'),
    Journey2(
        from: "Rukamlgama",
        to: "Maharagama",
        distance: "15",
        fare: "220.00",
        date: '2022-11-1'),
    Journey2(
        from: "Rukamlgama",
        to: "Kottawa",
        distance: "10",
        fare: "150.00",
        date: '2022-11-2'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: Column(
          children: journies.map((journey) {
            return Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              color: Colors.green[100],
              child: ListTile(
                title: Text(journey.date),
                subtitle: Text("${journey.from} to  ${journey.to} the distance ${journey.distance} and fare was ${journey.fare}"),
                
              ),
            );
          }).toList(),
        ));
  }
}
