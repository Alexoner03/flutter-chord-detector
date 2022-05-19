import 'package:guitar/models/BackendModels.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class BackendService {

  static const String url = "guitarra-app.herokuapp.com";

  static Future<UserInfo> getUserByEmail(String email) async {
    Map<String, String> queryParams = {
      'email': email,
    };
    var url = Uri.https(BackendService.url,"/api/user",queryParams);

    var response = await http.get(url);

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> createUser(String email) async {

    var url = Uri.https(BackendService.url,"/api/user");

    var response = await http.post(url, body: { email });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> updateChords(String email, List<Sound> chords) async {
    final _chords = convert.jsonEncode(chords.map((e) => e.toJson()).toList());

    var url = Uri.https(BackendService.url,"/api/user/chords");

    var response = await http.put(url, body: { "email" : email, "chords" : _chords });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> updateNotes(String email, List<Sound> notes) async {

    final _notes = convert.jsonEncode(notes.map((e) => e.toJson()).toList());

    var url = Uri.https(BackendService.url,"/api/user/notes");

    var response = await http.put(url, body: { "email" : email, "notes" : _notes}, );

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }

  static Future<UserInfo> updateTests(String email, List<Test> tests) async {
    final _tests = convert.jsonEncode(tests.map((e) => e.toJson()).toList());

    var url = Uri.https(BackendService.url,"/api/user/tests");

    var response = await http.put(url, body: { "email" : email, "tests": _tests });

    return UserInfo.fromJson(convert.jsonDecode(response.body));
  }
}