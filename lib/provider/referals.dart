import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart'; // Required for clipboard functionality

class ReferralPage extends StatefulWidget {
  @override
  _ReferralPageState createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
 late String referralId;

  @override
  void initState() {
    super.initState();
    referralId = generateReferralId();
  }

  String generateReferralId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(8, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  void copyReferralId() {
    Clipboard.setData(ClipboardData(text: referralId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Referral ID copied to clipboard')),
    );
  }

  void referFriend(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Share via',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for sharing via WhatsApp
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('WhatsApp'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for sharing via Facebook
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Facebook'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for sharing via Twitter
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Twitter'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for sharing via Email
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Email'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality for sharing via Email
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Email'),
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
        title: Text('Referral Page'),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite Your Friends!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Share your referral ID and earn rewards for every friend who joins.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          // Referral ID Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Referral ID',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        referralId,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: copyReferralId,
                  child: Text('Copy'),
                ),
              ],
            ),
          ),
          // Refer Friend Button
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () => referFriend(context),
              child: Text('Refer a Friend'),
            ),
          ),
        ],
      ),
    );
  }
}
