import 'package:guitar/models/BackendModels.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class BackendProvider {

  static const url = "144.217.6.17:8080/api";

  static Future<UserInfo> getUserByEmail(String email) async {
    Map<String, String> queryParams = {
      'email': email,
    };
    var url = Uri.http(BackendProvider.url,"/user",queryParams);

    var response = await http.get(url);

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> createUser(String email) async {

    var url = Uri.http(BackendProvider.url,"/user");

    var response = await http.post(url, body: { email });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> updateChords(String email, List<Sound> chords) async {

    var url = Uri.http(BackendProvider.url,"/user/chords");

    var response = await http.put(url, body: { email, chords });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> updateNotes(String email, List<Sound> notes) async {

    var url = Uri.http(BackendProvider.url,"/user/notes");

    var response = await http.put(url, body: { email, notes });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> updateTests(String email, List<Test> tests) async {

    var url = Uri.http(BackendProvider.url,"/user/tests");

    var response = await http.put(url, body: { email, tests });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }
}