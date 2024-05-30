import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CountryCode {
// class CoutryCode extends ChangeNotifier {
  List<Country> countries = [];
  Future fetchCountries() async {
    try {
      final countryResponse = await Dio().get(
          'https://us-central1-mybuggy-development.cloudfunctions.net/api/v1/master-data/countries');
  
      final countryData = await countryResponse.data as List;
      // setState(() {
      countries =countryData.map((country) => Country.fromJson(country)).toList();
      // print(countries);
      return countryData;
      // notifyListeners(); // Notify listeners about the state change
      // });
    } catch (e) {
      print(e);
    }
  }
}

class Country {
  String? phonePrefix;
  String? alts;
  String? name;
  String? threeLetterCode;
  int? id;
  String? region;
  String? shortCode;

  Country(
      {this.phonePrefix,
      this.alts,
      this.name,
      this.threeLetterCode,
      this.id,
      this.region,
      this.shortCode});

  Country.fromJson(Map<String, dynamic> json) {
    phonePrefix = json['phonePrefix'];
    alts = json['alts'];
    name = json['name'];
    threeLetterCode = json['threeLetterCode'];
    id = json['id'];
    region = json['region'];
    shortCode = json['shortCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phonePrefix'] = phonePrefix;
    data['alts'] = alts;
    data['name'] = name;
    data['threeLetterCode'] = threeLetterCode;
    data['id'] = id;
    data['region'] = region;
    data['shortCode'] = shortCode;
    return data;
  }
}


