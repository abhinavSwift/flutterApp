import 'package:flutter/material.dart';
import 'package:passenger_app/login/managedTrust.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showDeleteOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(14.0),
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Deactivate your Account Instead of deleting?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Add your deactivate account logic here
                },
                child: Text('Deactivate Account'),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ListTile(
              title: Text('User Name'),
              subtitle: Text('John Doe'),
            ),
            const ListTile(
              title: Text('Contact No'),
              subtitle: Text('+1234567890'),
            ),
            const ListTile(
              title: Text(
                'Favorites',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Add Home'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to add home screen
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Add Work'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to add work screen
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Trust Contact'),
              subtitle: Text('Manage trusted contacts'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrustPage()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _showDeleteOptions(context);
              },
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: () {
                // Perform sign out action
              },
            ),
          ],
        ),
      ),
    );
  }
}
