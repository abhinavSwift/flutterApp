import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Central Icon
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 20.0),
          //   child: const Center(
          //     child: Icon(
          //       Icons.notifications,
          //       size: 100.0,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
          // Notifications List
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Notification 1'),
                  subtitle: Text('This is the detail of notification 1.'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Notification 2'),
                  subtitle: Text('This is the detail of notification 2.'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Notification 3'),
                  subtitle: Text('This is the detail of notification 3.'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Notification 4'),
                  subtitle: Text('This is the detail of notification 4.'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Notification 5'),
                  subtitle: Text('This is the detail of notification 5.'),
                ),
                // Add more ListTile widgets for additional notifications
              ],
            ),
          ),
        ],
      ),
    );
  }
}

