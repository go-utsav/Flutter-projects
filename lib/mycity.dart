import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:locationselector/SelectedItemsPage.dart';
import 'package:locationselector/mycountry.dart';

class MyCityPage extends StatefulWidget {
  const MyCityPage({Key? key}) : super(key: key);

  @override
  State<MyCityPage> createState() => _MyCityPageState();
}

class _MyCityPageState extends State<MyCityPage> {

  List<String> cityList = [];

  @override
  void initState() {
    super.initState();
    getStateList();
  }
    
  Future<void> getStateList() async {
    Dio dio = new Dio();

    try {
      Response response = await dio.get("https://chat.vagatrip.com/data/state/12/cities");
      if (response.statusCode == 200){
        var citydata = response.data;
        var cityArr = citydata['data'];
        cityList.clear();

        for (var i = 0; i < cityArr.length; i++) {
          cityList.add(cityArr[i]['city_name']);
          cityList.sort();
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
    // final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final String country = args['country'];
    // final String state = args['state'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Select city'),
        centerTitle: true,
      ),
      body: cityList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(cityList[index],
                  style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 25.0
                    ),),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/selectedItems',
                      arguments: {
                        // 'country': country,
                        // 'state': state,
                        'city': cityList[index],
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
