import 'package:flutter/material.dart';

class trustPage extends StatelessWidget {
  const trustPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Trusted contacts lets you share your trip status with family and friends Set personalized reminders so you never forget to share trips Trips will never be shared without your permission Privacy Policy',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Email: info@yourcompany.com',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Phone: +1 123-456-7890',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Add functionality for first button
              },
              child: Text(
                'Call Now',
                style: TextStyle(fontSize: 18.0),
              ),
              // color: Colors.blue,
              // textColor: Colors.white,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Add functionality for second button
              },
              child: const Text(
                'Send Email',
                style: TextStyle(fontSize: 18.0),
              ),
              // color: Colors.blue,
              // textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
