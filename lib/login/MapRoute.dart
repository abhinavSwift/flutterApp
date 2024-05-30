import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passenger_app/login/login.dart';

class DistanceCalc extends StatefulWidget {
  const DistanceCalc({super.key});

  @override
  State<DistanceCalc> createState() => _DistanceCalcState();
}

 TextEditingController _originController = TextEditingController();
 TextEditingController _destinationController = TextEditingController();
 String _distanceText = "";
 String _timeText = "";





class _DistanceCalcState extends State<DistanceCalc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Route Page .."),
        backgroundColor: Colors.lightBlue[400],
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              icon: const Icon(
                Icons.door_back_door,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _originController,
              decoration: const InputDecoration(
                labelText: 'Enter origin',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Enter destination',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print(_originController.text);
              print(_destinationController.text);
              print("hi");
            },
            child: Text("Get Distance"),
          ),
          if (_distanceText.isNotEmpty && _timeText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Distance: $_distanceText'),
                  Text('Time: $_timeText'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
