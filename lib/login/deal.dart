import 'package:flutter/material.dart';
import 'package:passenger_app/login/WelcomeScreen.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deals'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://via.placeholder.com/150', // Placeholder image URL
                width: 150, // Adjust the width as needed
                height: 150, // Adjust the height as needed
              ),
              SizedBox(height: 20),
              Text(
                "Oh no! We currently don't have any deals to offer. Stay tuned for exciting updates!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
