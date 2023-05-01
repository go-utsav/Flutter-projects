// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:locationselector/SelectedItemsPage.dart';
import 'package:locationselector/dashboard.dart';
import 'package:locationselector/mycity.dart';
import 'package:locationselector/mycountry.dart';
import 'package:locationselector/mystate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Country App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => dashboardPage(),
        '/selectedCountry': (context) => MycountryPage(),
        '/selectedState': (context) => myStatePage(),
        '/selectedCity': (context) => MyCityPage(),
        '/selectedItems': (context) => SelectedItemPage()

      },
    );
  }
}

class SelectionsModel {
  String selectedCountry;
  String selectedState;
  String selectedCity;

  SelectionsModel({
    required this.selectedCountry,
    required this.selectedState,
    required this.selectedCity,
  });
}
