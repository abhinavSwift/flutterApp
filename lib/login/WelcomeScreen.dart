import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passenger_app/login/login.dart';
import 'package:passenger_app/login/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';

// TODO :-  get a user device location permission
// after getting
// TODO:- calculate distance between fixed locaton to user location
// and show to user

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller = Completer();
  // final distanceService = DistanceMatrixService();
  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: "AIzaSyA6ZUMXveSvj4QaSMnYVOIMS9GwfHXJp_Y");
  List<LatLng>? cordinatesPosition;
  var currentUserNumber = (FirebaseAuth.instance.currentUser).toString();

  static const CameraPosition _cameraposition = CameraPosition(
    target: LatLng(25.611219, 85.130692),
    zoom: 17,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(25.611219, 85.130692),
      infoWindow: InfoWindow(
        title: 'Current',
      ),
    ),
  ];

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future setPolylinePoints() async {
    try {
      final cordinates = await googleMapPolyline.getCoordinatesWithLocation(
          origin: const LatLng(25.611219, 85.130692),
          destination: const LatLng(25.617647, 85.143806),
          mode: RouteMode.driving);
      if (cordinates != null && cordinates.length > 1) {
        setState(() {
          cordinatesPosition = cordinates;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome rider.."),
        backgroundColor: Colors.lightBlue[400],
        
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.blue.shade100,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1485290334039-a3c69043e517?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyOTU3NDE0MQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
              ),
              accountName: Text(currentUserNumber.toString()),
              accountEmail: Text('Akimabhinav@gmail.com'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(context,  MaterialPageRoute(
                              builder: (context) => ProfileScreen()
                            ),);
                
              },
            ),
            ListTile(
              title: const Text('Wallet'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('mytrip'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Referral'),
              onTap: () {
                
              },
            ),
            
            ListTile(
              title: const Text('Deals'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Need Help?'),
              onTap: () {
                
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
                onTap: () async {
                   var uri = Uri.parse("https://easytaxiservices.com/privacy-policy/");
                    if (await canLaunchUrl(uri)){
    await launchUrl(uri);
                          } else {
                               // can't launch url
                                        }
                  
            //  js.context.callMethod('open', ['https://stackoverflow.com/questions/ask']);
            //  this.window.open('https://stackoverflow.com/questions/ask', 'new tab');
          }
              
            ),
            ListTile(
              title: const Text('Terms & Conditions'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
      body: 
      GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setPolylinePoints();
        },
        trafficEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        initialCameraPosition: _cameraposition,
        markers: Set<Marker>.of(_markers),
        mapType: MapType.normal,
        polylines: cordinatesPosition != null
            ? Set<Polyline>.of(
                [
                  Polyline(
                    polylineId: PolylineId("mybuggy"),
                    points: cordinatesPosition!,
                    visible: true,
                    color: Colors.blue.shade400,
                  ),
                ],
              )
            : const <Polyline>{},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        // floatingActionButton: FloatingActionButton(

        onPressed: () async {
          getUserCurrentLocation().then(
            (value) async {
              if (kDebugMode) {
                print("${value.latitude} ${value.longitude}");
              }

              // double distance = await calculateDistance(25.611219  ,  85.130692, 25.617647,85.143806 );
              //     print('The distance is: $distance meters');
              // double distanceInMeters = await Geolocator.distanceBetween(
              //     25.611219, 85.130692, 25.6119212,85.112484);
              //     String kiloMeter =  (distanceInMeters/1000.0).toString();
              // print(' total dummy1 distance :---- $distanceInMeters , kilometer is $kiloMeter');

              // double distanceInKilometers =
              //     await distanceService.getDistanceInKilometers(
              //         25.611219, 85.130692, 25.6119212, 85.112484);
              // print(
              //     'Distance between locations: $distanceInKilometers kilometers');

              _markers.add(
                Marker(
                  markerId: const MarkerId("2"),
                  position: LatLng(value.latitude, value.longitude),
                  infoWindow: const InfoWindow(
                    title: 'Live Location',
                  ),
                ),
              );
              CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude),
                zoom: 17,
              );

              // ! Work on calculate distance

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.pin_drop_outlined),
        // padding: const EdgeInsets.only(right: 20.0),
      ),
    );
  }
}
