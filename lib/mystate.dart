import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locationselector/mycity.dart';

class myStatePage extends StatefulWidget {
  const myStatePage({Key? key}) : super(key: key);

  @override
  State<myStatePage> createState() => _myStatePageState();
}

class _myStatePageState extends State<myStatePage> {
  List<String> stateList = [];

  @override
  void initState() {
    super.initState();
    getStateList();
  }

  Future<void> getStateList() async {
    Dio dio = new Dio();
    try {
      Response response = await dio
          .get("https://chat.vagatrip.com/data/country/101/states");

      if (response.statusCode == 200) {
        var data = response.data;
        var stateArr = data['data'];
        stateList = [];

        for (var i = 0; i < stateArr.length; i++) {
          stateList.add(stateArr[i]['state_name']);
          stateList.sort();
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
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final String country = args['country'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Select State"),
        centerTitle: true,
      ),
      body: stateList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: stateList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(stateList[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                         fontSize: 25.0
                      ),),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/selectedCity',
                        arguments: {
                          // 'country': args['country'],
                          'state': stateList[index]
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
