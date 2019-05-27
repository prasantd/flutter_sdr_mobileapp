import 'package:flutter_sdr_app/model/sponsorsjson.dart';
import 'package:http/http.dart' as http;

String url =
    'https://shuddhdesiradio.wixsite.com/sdrradio/_functions/getsponsorimages/m';

Future<SponsorList> getSponsor() async {
  final response = await http.get('$url/1');
  if (response.statusCode == 200)
    return getFromJson(response.body);
  else
    throw Exception('Unable to retrieve Sponsors');
}
