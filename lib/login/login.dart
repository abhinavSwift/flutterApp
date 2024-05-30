import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:passenger_app/login/OtpAuth.dart';
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
              ],
            ),
    );
  }
}












































































// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/countries.dart';
// // import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:passenger_app/login/OtpAuth.dart';
// import 'package:provider/provider.dart';
// import '../provider/CountryCode_provider.dart';
// // import 'package:intl_phone_field/intl_phone_field.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   _Login createState() => _Login();
// }

// class _Login extends State<Login> {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   // String _selectedCountryCode = '+91'; // Default country code
//   List phonePrefixOfCountry = [];
//   CountryCode countryCode = CountryCode();

//   @override
//   void initState() {
//     // _phoneNumberController.dispose();
//     super.initState();
//     prefixData();

//   }

//   void showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red, // Optional: Set error color
//       ),
//     );
//   }

//   Future  prefixData() async {
//      await countryCode.fetchCountries().then(
//           (value) => value.forEach(
//             (data) => {
//               if (data['phonePrefix'] != null)
//                 {phonePrefixOfCountry.add(data["phonePrefix"])}
//             },
//           ),
//         );
//       print(phonePrefixOfCountry);
//       print("hi");
//   }
  
//   List<DropdownMenuItem<String>> getCountryCodes() {
//     return [
//       const DropdownMenuItem(value: '+1', child: Text('USA (+1)')),
//       const DropdownMenuItem(value: '+44', child: Text('UK (+44)')),
//       const DropdownMenuItem(value: '+91', child: Text('IN (+91)')),
//       // Add more country codes as needed
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Login With Phone Number"),
//         backgroundColor: Colors.lightBlue[400],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             children: [
//               const SizedBox(
//                 width: 5,
//               ),

//               DropdownButtonHideUnderline(
//                 child: phonePrefixOfCountry.isEmpty
//                     ? const CircularProgressIndicator()
//                     : DropdownButton(
                  
//                         value: phonePrefixOfCountry.first,
//                         items: phonePrefixOfCountry
//                             .map((prefix) => DropdownMenuItem(
//                                   value: prefix,
//                                   child: Text(prefix),
//                                 ))
//                             .toList(),
//                         onChanged: (prefix) {},
//                       ),
//               ),
//               const SizedBox(width: 0),
//               Expanded(
//                 //  flex: 1,
//                 child: TextFormField(
//                   controller: _phoneNumberController,
//                   keyboardType: TextInputType.phone,
//                   decoration: const InputDecoration(
//                     // suffixIcon: Icon(Icon.phone),
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 20),

//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(16),
//                       ),
//                     ),
//                     labelText: 'Phone No',
//                   ),
//                 ),
//               ),
//               // const SizedBox(width: -10,)
//             ],
//           ),
//           //? There should be a elevated button
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.verifyPhoneNumber(
//                 phoneNumber: _phoneNumberController.text.toString(),
//                 verificationCompleted: (PhoneAuthCredential credential) {},
//                 verificationFailed: (FirebaseAuthException e) {},
//                 codeSent: (String verificationId, int? resendToken) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => OtpAuth(
//                           verificationId: verificationId,
//                         ),
//                       ));
//                 },
//                 codeAutoRetrievalTimeout: (String verificationId) {},
//               );
//             },
//             child: const Text('login', textScaler: TextScaler.linear(1.5)),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               // coutryCode.countries.forEach((element) {
//               //   print(element);
//               // });
//               await countryCode
//                   .fetchCountries()
//                   .then((value) => value.forEach((data) => {
//                         if (data['phonePrefix'] != null)
//                           {phonePrefixOfCountry.add(data["phonePrefix"])}
//                       }));

//               print(phonePrefixOfCountry);
//               print("hi");
//             },
//             child: Text("CHECK"),
//           )
//         ],
//       ),
//     );
//   }
// }
