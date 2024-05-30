import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:passenger_app/login/OtpAuth.dart';
import 'package:passenger_app/login/signup.dart';
import '../provider/CountryCode_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();

  String _selectedCountryCode = '+91';

  List<String> phonePrefixOfCountry = [];
  CountryCode countryCode = CountryCode();
  String? selectedCountryCode;

  @override
  void initState() {
    super.initState();
    prefixData();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red, // Optional: Set error color
      ),
    );
  }

  Future<void> prefixData() async {
    try {
      await countryCode.fetchCountries().then((value) {
        setState(() {
          phonePrefixOfCountry = value
              .where((data) => data['phonePrefix'] != null)
              .map<String>((data) => data['phonePrefix'].toString())
              .toList();
          phonePrefixOfCountry.add(_selectedCountryCode);
          if (phonePrefixOfCountry.isNotEmpty) {
            selectedCountryCode = phonePrefixOfCountry.last;
          }
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login With Phone Number"),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: phonePrefixOfCountry.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCountryCode,
                        items: phonePrefixOfCountry
                            .map((prefix) => DropdownMenuItem<String>(
                                  value: prefix,
                                  child: Text(prefix),
                                ))
                            .toList(),
                        onChanged: (String? prefix) {
                          setState(() {
                            selectedCountryCode = prefix;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          labelText: 'Phone No',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedCountryCode == null ||
                        _phoneNumberController.text.isEmpty) {
                      showError("Please enter a valid phone number.");
                      return;
                    }
                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '$selectedCountryCode${_phoneNumberController.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          showError(e.message ?? "Verification failed");
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpAuth(
                                verificationId: verificationId,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    } catch (e) {
                      showError("Failed to verify phone number: $e");
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 30), // Add some space
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                  },
                  child: Text("Don't have account , Register"),
                )
              ],
            ),
    );
  }
}
