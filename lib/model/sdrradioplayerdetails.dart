import 'dart:convert';

CurrentTrack getCurrentTrackDetails(String str) {
  final jsonData = json.decode(str);
  return CurrentTrack.fromJson(jsonData);
}

class CurrentTrack {
  final SDRPlayerDetails nowPlayingInfo;

  CurrentTrack({
    this.nowPlayingInfo,
  });

  factory CurrentTrack.fromJson(Map<String, dynamic> parsedJson) {
    return CurrentTrack(
      nowPlayingInfo: SDRPlayerDetails.fromJson(parsedJson['current_track']),
    );
  }
}

class SDRPlayerDetails {
  String titleTrack;

  SDRPlayerDetails({
    this.titleTrack,
  });

  factory SDRPlayerDetails.fromJson(Map<String, dynamic> json) {
    return SDRPlayerDetails(
      titleTrack: json["title"],
    );
  }
}
