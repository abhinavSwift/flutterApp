import 'dart:async';
// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class PageCountry extends StatefulWidget {
  const PageCountry({super.key});

  @override
  State<PageCountry> createState() => _PageCountryState();
}

class _PageCountryState extends State<PageCountry> {
  List<Country> countries = [];
  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future fetchCountries() async {
    try {
      final countryResponse = await Dio().get(
          'https://us-central1-mybuggy-development.cloudfunctions.net/api/v1/master-data/countries');
      print(countryResponse);
      final countryData = countryResponse.data as List;
      setState(() {
        countries =
            countryData.map((country) => Country.fromJson(country)).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: countries.isEmpty
              ? const CircularProgressIndicator()
              : DropdownButton<Country>(
                  isExpanded: true, // Expand dropdown to full width
                  value: countries.first, // Set initial selection
                  items: countries
                      .map((album) => DropdownMenuItem<Country>(
                            value: album,
                            child: Text(album.shortCode!),
                          ))
                      .toList(),
                  onChanged: (album) {}),
        ),
      ),
    );
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonePrefix'] = this.phonePrefix;
    data['alts'] = this.alts;
    data['name'] = this.name;
    data['threeLetterCode'] = this.threeLetterCode;
    data['id'] = this.id;
    data['region'] = this.region;
    data['shortCode'] = this.shortCode;
    return data;
  }
}
