import 'package:flutter/material.dart';
import 'trip.dart';
import 'package:intl/intl.dart';




class MyTripsPage extends StatefulWidget {
  const MyTripsPage({super.key});

  @override
  _MyTripsPageState createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  String selectedCategory = 'Upcoming Rides';

  final List<Trip> trips = [
    Trip(origin: 'Brooklyn', destination: 'Manhattan', date: '2022-05-01', cost: 150.0, rideId: 'NY12345'),
    Trip(origin: 'Santa Monica', destination: 'Downtown LA', date: '2023-06-15', cost: 200.0, rideId: 'LA12345'),
    Trip(origin: 'Navy Pier', destination: 'Millennium Park', date: '2023-07-20', cost: 180.0, rideId: 'CH12345'),
    Trip(origin: 'Brooklyn', destination: 'Queens', date: '2023-04-20', cost: 80.0, rideId: 'NY54321'),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<Trip> previousRides = trips.where((trip) => DateTime.parse(trip.date).isBefore(today)).toList();
    List<Trip> upcomingRides = trips.where((trip) => DateTime.parse(trip.date).isAfter(today) || DateTime.parse(trip.date).isAtSameMomentAs(today)).toList();

    List<Trip> displayedRides = selectedCategory == 'Previous Rides' ? previousRides : upcomingRides;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips user'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: <String>['Upcoming Rides', 'Previous Rides']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: displayedRides.length,
                itemBuilder: (context, index) {
                  final trip = displayedRides[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ride ID: ${trip.rideId}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          Text('From: ${trip.origin}'),
                          Text('To: ${trip.destination}'),
                          Text('Date: ${trip.date}'),
                          Text('Cost: \$${trip.cost}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
