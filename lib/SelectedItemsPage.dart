import 'package:flutter/material.dart';

class SelectedItemPage extends StatefulWidget {
  const SelectedItemPage({super.key});

  @override
  State<SelectedItemPage> createState() => _SelectedItemPageState();
}


class _SelectedItemPageState extends State<SelectedItemPage> {

  

  @override
  Widget build(BuildContext context) {

    //  final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final String country = args['country'];
    // final String state = args['state'];
    // final String city = args['city'];
    


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

             Text("India\n\n", 
             style: TextStyle(
              fontSize: 30.0,
             )),

             Text("Selected State\n",
            style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
            ),),

             Text('Gujarat\n\n', 
             style: TextStyle(
              fontSize: 30.0,
             )),

             Text("Selected City\n",
            style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
            ),),

            Text('Ahmedabad\n\n', 
             style: TextStyle(
              fontSize: 30.0,
             )),
          ],
        ),
      ),
    );
  }
}