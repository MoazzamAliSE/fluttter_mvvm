// dart imports
import 'dart:convert';

// package imports
import 'package:flutter_mvvm/model/data_model.dart';
import 'package:http/http.dart';

// app imports
class ApiService {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'https://corona.lmao.ninja/v2';

  Future<List<DataModel>> getData() async {
    Uri uri = Uri.parse('$BASE_URL/countries?yesterday&sort');
    Response response = await get(uri);

    if (response.statusCode == 200) {
      List<dynamic> parsedJson = jsonDecode(response.body);
      List<DataModel> data =
          parsedJson.map((json) => DataModel.fromJson(json)).toList();
      print("data");
      return data;
    } else {
      throw 'Error while fetching data';
    }
  }
}
