import 'package:http/http.dart' as http;
import 'package:flutter_sdr_app/model/sdrradioplayerdetails.dart';

String url = 'https://public.radio.co/stations/se30891e37/status';

Future<CurrentTrack> getCurrentDetails() async {
  final response = await http.get('$url');
  print(response.body);
  if (response.statusCode == 200)
    return getCurrentTrackDetails(response.body);
  else
    throw Exception('Cannot obtain title');
}
