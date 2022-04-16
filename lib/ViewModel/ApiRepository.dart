import 'dart:convert';

import 'package:algostudiotest/Model/MemeData.dart';
import 'package:http/http.dart' as http;

class ApiRepository {

  static Future<MemeData> getMemeData() async {
    var client = http.Client();
    try {
      http.Response result = await client
          .get(Uri.parse("https://api.imgflip.com/get_memes"), headers: {
        'Accept': 'application/json',
      });
      print("Get Meme data: ${result.body}");
      client.close();
      return MemeData.fromJson(json.decode(result.body));
    } catch (e) {
      print(e);
      client.close();
      return MemeData(success: false);
    }
  }
}