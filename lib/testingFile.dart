// import 'dart:async';
// import 'dart:math' show cos, sqrt, asin;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:passenger_app/login/login.dart';
// import 'package:google_map_polyline_new/google_map_polyline_new.dart';

// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   late GoogleMapController mapController;
//   final Completer<GoogleMapController> _controller = Completer();
//   GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(apiKey: "YOUR_GOOGLE_MAPS_API_KEY");
//   List<LatLng>? coordinatesPosition;

//   static const CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(25.611219, 85.130692),
//     zoom: 17,
//   );

//   final List<Marker> _markers = <Marker>[
//     const Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(25.611219, 85.130692),
//       infoWindow: InfoWindow(
//         title: 'Current',
//       ),
//     ),
//   ];

//   final TextEditingController _originController = TextEditingController();
//   final TextEditingController _destinationController = TextEditingController();
//   String _distanceText = "";

//   Future<Position> getUserCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//     _controller.complete(controller);
//   }

//   Future setPolylinePoints(LatLng origin, LatLng destination) async {
//     try {
//       final coordinates = await googleMapPolyline.getCoordinatesWithLocation(
//         origin: origin,
//         destination: destination,
//         mode: RouteMode.driving,
//       );
//       if (coordinates != null && coordinates.length > 1) {
//         setState(() {
//           coordinatesPosition = coordinates;
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   double calculateDistance(LatLng start, LatLng end) {
//     var p = 0.017453292519943295;
//     var a = 0.5 - cos((end.latitude - start.latitude) * p) / 2 +
//         cos(start.latitude * p) * cos(end.latitude * p) *
//             (1 - cos((end.longitude - start.longitude) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Welcome Home Buddy.."),
//         backgroundColor: Colors.lightBlue[400],
//         actions: [
//           IconButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Login(),
//                   ),
//                 );
//               },
//               icon: const Icon(
//                 Icons.door_back_door,
//               ))
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _originController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter origin coordinates (lat, long)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _destinationController,
//               decoration: const InputDecoration(
//                 labelText: 'Enter destination coordinates (lat, long)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               List<String> originCoordinates = _originController.text.split(',');
//               List<String> destinationCoordinates = _destinationController.text.split(',');
//               print("..................... $originCoordinates ---------- $destinationCoordinates");

//               LatLng origin = LatLng(
//                 double.parse(originCoordinates[0].trim()),
//                 double.parse(originCoordinates[1].trim()),
//               );
//               LatLng destination = LatLng(
//                 double.parse(destinationCoordinates[0].trim()),
//                 double.parse(destinationCoordinates[1].trim()),
//               );

//               // setPolylinePoints(origin, destination);

//               double distance = calculateDistance(origin, destination);
//               setState(() {
//                 _distanceText = "Distance: ${distance.toStringAsFixed(2)} km";
//                 // _distanceText = "origin ${originCoordinates} and Dsetination";
//               });
//               print('origin $originCoordinates and destination $destinationCoordinates');

//               _markers.add(
//                 Marker(
//                   markerId: const MarkerId("2"),
//                   position: origin,
//                   infoWindow: const InfoWindow(
//                     title: 'Origin',
//                   ),
//                 ),
//               );

//               _markers.add(
//                 Marker(
//                   markerId: const MarkerId("3"),
//                   position: destination,
//                   infoWindow: const InfoWindow(
//                     title: 'Destination',
//                   ),
//                 ),
//               );

//               CameraPosition cameraPosition = CameraPosition(
//                 target: origin,
//                 zoom: 10,
//               );

//               final GoogleMapController controller = await _controller.future;
//               controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//               setState(() {});
//             },
//             child: const Text('Calculate Distance'),
//           ),
//           Text(
//             _distanceText,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               trafficEnabled: true,
//               myLocationEnabled: true,
//               compassEnabled: true,
//               initialCameraPosition: _initialCameraPosition,
//               markers: Set<Marker>.of(_markers),
//               mapType: MapType.normal,
//               polylines: coordinatesPosition != null
//                   ? Set<Polyline>.of(
//                       [
//                         Polyline(
//                           polylineId: const PolylineId("route"),
//                           points: coordinatesPosition!,
//                           visible: true,
//                           color: Colors.blue.shade400,
//                         ),
//                       ],
//                     )
//                   : const <Polyline>{},
//             ),
//           ),
//         ],
//       ),
//       // 
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           getUserCurrentLocation().then(
//             (value) async {
//               if (kDebugMode) {
//                 print("${value.latitude} ${value.longitude}");
//               }

//               _markers.add(
//                 Marker(
//                   markerId: const MarkerId("2"),
//                   position: LatLng(value.latitude, value.longitude),
//                   infoWindow: const InfoWindow(
//                     title: 'Live Location',
//                   ),
//                 ),
//               );
//               CameraPosition cameraPosition = CameraPosition(
//                 target: LatLng(value.latitude, value.longitude),
//                 zoom: 15,
//               );

//               final GoogleMapController controller = await _controller.future;
//               controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//               setState(() {});
//             },
//           );
//         },
//         child: const Icon(Icons.pin_drop_outlined),
//       ),
//     );
//   }
// }
