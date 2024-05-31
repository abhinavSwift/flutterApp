import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passenger_app/login/deal.dart';
import 'package:passenger_app/login/login.dart';
import 'package:passenger_app/login/notifactions.dart';
import 'package:passenger_app/login/profile.dart';
import 'package:passenger_app/login/setting.dart';
import 'package:passenger_app/referral/referals.dart';
import 'package:passenger_app/trip/myTrips.dart';
import 'package:passenger_app/wallet/wallet.dart';
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
  var currentUserNumber =  FirebaseAuth.instance.currentUser?.phoneNumber ?? 'Unknown Number';
  
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
      endDrawer:Drawer(
      child: Column(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            accountName: Text('Mo Iphone', style: TextStyle(color: Colors.white)),
            accountEmail: Text('mm@gmail.com', style: TextStyle(color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                'MI',
                style: TextStyle(fontSize: 40.0, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.trip_origin),
            title: Text('My Trips'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Wallet'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Referrals'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Deals'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle the action here
            },
          ),
          const Spacer(),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            title: const Text('Need Help?', style: TextStyle(color: Colors.purple)),
            onTap: () {
              // Handle the action here
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            title: const Text('Terms & Conditions'),
            onTap: () {
              // Handle the action here
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('v2.0', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    ),
      body: GoogleMap(
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
