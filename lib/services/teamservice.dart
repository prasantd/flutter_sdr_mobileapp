import 'package:flutter_sdr_app/model/sdrteammodel.dart';
import 'package:http/http.dart' as http;

String url =
    'https://shuddhdesiradio.wixsite.com/sdrradio/_functions/getsdrteamlist';

Future<TeamList> getTeamList() async {
  final response = await http.get('$url/1');

  if (response.statusCode == 200) {
    return getFromJson(response.body);
  } else
    throw Exception('Unable to retrieve Team');
}
