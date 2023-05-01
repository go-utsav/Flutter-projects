import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:locationselector/mystate.dart';


class MycountryPage extends StatefulWidget {
  const MycountryPage({Key? key}) : super(key: key);

  @override
  State<MycountryPage> createState() => _MycountryPageState();
}


class _MycountryPageState extends State<MycountryPage> {
  List<String> countryList = [];
  List<String> SelectedItem = [];
  

  @override
  void initState() {
    super.initState();
    fetchCountryList();
  }

  Future<void> fetchCountryList() async {
    try {
      Dio dio = new Dio();
      Response response =
          await dio.get("https://chat.vagatrip.com/data/country/list");

      if (response.statusCode == 200) {
        var data = response.data;
        var countryarr = data['data'];
        countryList.clear();
        for (var i = 0; i < countryarr.length; i++) {
          countryList.add(countryarr[i]['name']);
          countryList.sort();
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
        body:  countryList.isEmpty
          ? Center(child: CircularProgressIndicator())
          :ListView.builder(
  itemCount: countryList.length,
  itemBuilder: (BuildContext context, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(countryList[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
           fontSize: 25.0
        ),),
        onTap: () {
          SelectedItem.add(countryList[index]);
          Navigator.pushNamed(
            context,
            '/selectedState',
            arguments: {'selectedItems': [...SelectedItem, countryList[index]]},
          );
        },
      ),
    );
  },
)
);
  }
}
