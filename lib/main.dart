import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Selector',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: dashboard(),
    );
  }
}

class Location {
  final String country;
  final String state;
  final String city;

  Location({required this.country, required this.state, required this.city});
}

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
     body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          FaIcon(
          FontAwesomeIcons.mapMarkerAlt,
          size: 350.0,
          color: Colors.green,
        ),
        Text('\n\n\n'),
        Text('Location Selector',
        style: TextStyle(
          color: Colors.orange,
          fontSize: 50.0,
          fontWeight: FontWeight.w600
        ),),
        Text('Application',
         style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w400
        ),),
        Text('\n\n\n'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => CountryPage()));
             
            },
            child: Text('Lets Get Started',
            style: TextStyle(
          fontSize: 20.0,
          
        )),
          )
        ],
      ),)
    ); 
  }
}
class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      Dio dio = new Dio();
      Response response =
          await dio.get("https://chat.vagatrip.com/data/country/list");

      if (response.statusCode == 200) {
        var data = response.data;
        var countryarr = data['data'];
        _countries.clear();
        for (var i = 0; i < countryarr.length; i++) {
          _countries.add(countryarr[i]['name']);
          _countries.sort();
        }
        setState(() {});
      } else {
        print('Some internal error: ');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Country Page'),
          centerTitle: true,
        ),
        body: _countries.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _countries.length,
                itemBuilder: (BuildContext context, int index) {
                  final country = _countries[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        _countries[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                      onTap: () {
                        final selectedCountry = _countries[index];
                        setState(() {
                          var _selectedCountry = country;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StatePage(selectedCountry),
                          ),
                        );
                      },
                    ),
                  );
                },
              ));
  }
}

class StatePage extends StatefulWidget {
  final String country;

  StatePage(this.country);

  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  List<String> _states = [];

  @override
  void initState() {
    super.initState();
    fetchStates();
  }

  Future<void> fetchStates() async {
  Dio dio = new Dio();
    try {
      Response response = await dio
          .get("https://chat.vagatrip.com/data/country/101/states");

      if (response.statusCode == 200) {
        var data = response.data;
        var stateArr = data['data'];
        _states = [];

        for (var i = 0; i < stateArr.length; i++) {
          _states.add(stateArr[i]['state_name']);
          _states.sort();
        }

        setState(() {});
      } else {
        print('Some internal error: ');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select State"),
        centerTitle: true,
      ),
      body: _states.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _states.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(_states[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                         fontSize: 25.0
                      ),),
                   onTap: () {
                    final selectedState = _states[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CityPage(widget.country, selectedState),
                      ),
                    );
                  },
                  ),
                );
              },
            ),
    );
  }
}

class CityPage extends StatefulWidget {
  final String country;
  final String state;

  CityPage(this.country, this.state);

  @override
  _CityPageState createState() => _CityPageState();
}
class _CityPageState extends State<CityPage> {
  List<String> _cities = [];

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    Dio dio = new Dio();

    try {
      Response response = await dio.get("https://chat.vagatrip.com/data/state/12/cities");
      if (response.statusCode == 200){
        var citydata = response.data;
        var cityArr = citydata['data'];
        _cities.clear();

        for (var i = 0; i < cityArr.length; i++) {
          _cities.add(cityArr[i]['city_name']);
          _cities.sort();
        }
        
        setState(() {});
        
      } else {
        print("Internal API error");
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Select city'),
        centerTitle: true,
      ),
      body: _cities.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: _cities.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(_cities[index],
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 25.0
                    ),),
                  onTap: () {
                    final selectedCity = _cities[index];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SelectedPage(widget.country, widget.state, selectedCity),
                      ),
                    );
                  }
                ),
                );
              },
            ),
    );
  }
}

class SelectedPage extends StatelessWidget {
  final String country;
  final String state;
  final String city;

  SelectedPage(this.country, this.state, this.city);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Selected Items'),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text("Selected Country\n",
            style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
            ),),

             Text("$country\n\n", 
             style: TextStyle(
              fontSize: 30.0,
             )),

             Text("Selected State\n",
            style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
            ),),

             Text(' $state\n\n', 
             style: TextStyle(
              fontSize: 30.0,
             )),

             Text("Selected City\n",
            style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
            ),),

            Text('$city\n\n', 
             style: TextStyle(
              fontSize: 30.0,
             )),
          ],
        ),
      ),
    );
  }
}
