import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:algostudiotest/Model/MemeData.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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

  // static Future<File> SaveFiles(String urlFiles, int ids) async {
  //   Completer<File> completer = Completer();
  //   int index = 0;
  //   try {
  //     var request = await http.get(Uri.parse(urlFiles));
  //     var dir = await getExternalStorageDirectories(
  //         type: StorageDirectory.downloads);
  //     File file = File("${dir?[index].path}/downloadFile$ids.jpg");
  //
  //     await file.writeAsBytes(request.bodyBytes, flush: true);
  //     print(file.path);
  //     completer.complete(file);
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Error parsing asset file!');
  //   }
  // }
}