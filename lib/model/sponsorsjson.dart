import 'dart:convert';

SponsorList getFromJson(String str) {
  final jsonData = json.decode(str);
  // print(jsonData);
  return SponsorList.fromJson(jsonData);
}

class SponsorList {
  final List<Sponsor> sponsors;

  SponsorList({
    this.sponsors,
  });

  factory SponsorList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<Sponsor> sponsors = list.map((i) => Sponsor.fromJson(i)).toList();
    return SponsorList(
      sponsors: sponsors,
    );
  }
}

class Sponsor {
  String sponsorId;
  String sponsorCompany;
  String sponsorLogo;

  Sponsor({
    this.sponsorId,
    this.sponsorCompany,
    this.sponsorLogo,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    String companyLogoUrl = json["companyLogo"];
    int firstPart = companyLogoUrl.indexOf("v1/", 0);
    int secondPart = companyLogoUrl.indexOf(".jpg", 0);
    companyLogoUrl = companyLogoUrl.substring(firstPart + 3, secondPart);
    String sponsorLogoUrl =
        'https://static.wixstatic.com/media/' + companyLogoUrl + '.jpg';
    return Sponsor(
      sponsorId: json["_id"],
      sponsorCompany: json["companyName"],
      sponsorLogo: sponsorLogoUrl,
    );
  }

//  Map<String, dynamic> toJson() => {
//    "sponsorId": sponsorId,
//    "sponsorCompany": sponsorCompany,
//   "sponsorLogo": sponsorLogo,
// };
}
