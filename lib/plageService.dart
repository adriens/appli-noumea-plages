
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:noumea_plages/Plage.dart';

const Map<String, String> HEADERS = {
  'x-rapidapi-key': '7f5a962014msh0a329900df3992ep1cb0cejsn40fdcc7e2ff4',
  'Content-type': 'application/json; charset=utf-8'
};

class PlageService {

  static Future<List<Plage>> getPlages() async {

    var resp = await http.get("https://eaux-baignade-noumea.p.rapidapi.com/plages", headers: HEADERS);
    Iterable i = json.decode(resp.body);
    List<Plage> plages = i.map((data) => Plage.fromJson(data)).toList();
    print(resp.body);
    return plages;

  }

}
