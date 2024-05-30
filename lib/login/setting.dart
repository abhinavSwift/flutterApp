import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                // Navigate to manage trusted contact screen
              },
            ),
            ListTile(
              title: Text('Privacy'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to privacy screen
              },
            ),
            ListTile(
              title: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Show confirmation dialog for account deletion
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
