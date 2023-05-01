import 'package:dio/dio.dart';

void main() async {
  List<String> cityList = [];
  Dio dio = new Dio();

  try {
    Response response = await dio.get("https://chat.vagatrip.com/data/state/12/cities");

    if( response.statusCode == 200) {
      var data = response.data;
      var cityArr = data['data'];

      print(cityArr.length);
      for (var i = 0; i < cityArr.length; i++) {
        cityList.add(cityArr[i]['city_name']);
        cityList.sort();
      }
       print(cityList);
    } else {
      print('Some internal error: ');
    }
  
  } catch(e) {
  print('Error: $e');
}
}
