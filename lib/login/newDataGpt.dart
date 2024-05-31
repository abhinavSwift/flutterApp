import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Drawer'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
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
            leading: Icon(Icons.people),
            title: Text('Referrals'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text('Deals'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle the action here
            },
          ),
          Spacer(),
          ListTile(
            title: Text('Sign Out'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            title: Text('Need Help?', style: TextStyle(color: Colors.purple)),
            onTap: () {
              // Handle the action here
            },
          ),
          Divider(),
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              // Handle the action here
            },
          ),
          ListTile(
            title: Text('Terms & Conditions'),
            onTap: () {
              // Handle the action here
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('v2.0', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
