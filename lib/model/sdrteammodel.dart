import 'dart:convert';
import 'package:flutter/foundation.dart';

TeamList getFromJson(String str) {
  final jsonData = json.decode(str);
  return TeamList.fromJson(jsonData);
}

class TeamList {
  final List<TeamMember> sdrRJs;

  TeamList({
    this.sdrRJs,
  });

  factory TeamList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    debugPrint(list.toString());
    List<TeamMember> teams = list.map((i) => TeamMember.fromJson(i)).toList();
    return TeamList(
      sdrRJs: teams,
    );
  }
}

class TeamMember {
  String memberName;
  String memberTitle;
  String memberLogoUrl;
  String memberBio;
  String memberLanguage;

  TeamMember({
    this.memberName,
    this.memberTitle,
    this.memberLogoUrl,
    this.memberBio,
    this.memberLanguage,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    String memberPicUrl = json["rjPicture"];
    String fileExtension = '.jpg';
    String rjLogoUrl = "";
    if (memberPicUrl != null) {
      int firstPart = memberPicUrl.indexOf("v1/", 0);
      int secondPart = memberPicUrl.indexOf(".jpg", 0);
      if (secondPart == -1) {
        secondPart = memberPicUrl.indexOf(".jpeg", 0);
        fileExtension = ".jpeg";
      }
      if (secondPart == -1) {
        secondPart = memberPicUrl.indexOf(".png", 0);
        fileExtension = ".png";
      }
      memberPicUrl = memberPicUrl.substring(firstPart + 3, secondPart);
      rjLogoUrl =
          'https://static.wixstatic.com/media/' + memberPicUrl + fileExtension;
    } else {
      rjLogoUrl = "";
    }

    return TeamMember(
      memberName: json["title"],
      memberTitle: json["rjTitle"],
      memberLogoUrl: rjLogoUrl,
      memberBio: json["rjBio"],
      memberLanguage: json["rjLanguage"],
    );
  }
}
