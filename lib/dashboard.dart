import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locationselector/mycountry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class dashboardPage extends StatefulWidget {
  const dashboardPage({super.key});

  @override
  State<dashboardPage> createState() => _dashboardPageState();
}

class _dashboardPageState extends State<dashboardPage> {
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
              MaterialPageRoute(builder: (context) => MycountryPage()));
             
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