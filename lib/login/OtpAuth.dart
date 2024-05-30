import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passenger_app/login/WelcomeScreen.dart';
// import 'package:passenger_app/login/WelcomeScreen.dart';
import 'package:passenger_app/testingFile.dart';

class OtpAuth extends StatefulWidget {
  
  String verificationId;
  OtpAuth({super.key, required this.verificationId});

  @override
  State<OtpAuth> createState() => _OtpAuthState();
}

class _OtpAuthState extends State<OtpAuth> {
  TextEditingController otpController = TextEditingController();

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red, // Optional: Set error color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('otp Screen'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[400],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: TextField(
              controller: otpController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Enter The OTP",
                suffixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              try {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otpController.text.toString());

                FirebaseAuth.instance
                    .signInWithCredential(credential)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                });
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
                // * NOTES
              }
            },
            child: const Text(
              'login',
              textScaler: TextScaler.linear(1.5),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
