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
    String sponsorLogoUrl = "";
    String fileExtension = ".jpg";
    if (companyLogoUrl != null) {
      int firstPart = companyLogoUrl.indexOf("v1/", 0);
      int secondPart = companyLogoUrl.indexOf(".jpg", 0);
      if (secondPart == -1) {
        secondPart = companyLogoUrl.indexOf(".jpeg", 0);
        fileExtension = ".jpeg";
      }
      if (secondPart == -1) {
        secondPart = companyLogoUrl.indexOf(".png", 0);
        fileExtension = ".png";
      }
      companyLogoUrl = companyLogoUrl.substring(firstPart + 3, secondPart);
      sponsorLogoUrl =
          'https://static.wixstatic.com/media/' + companyLogoUrl +
              fileExtension;
    }
    else {
      sponsorLogoUrl = "";
    }
    return Sponsor(
      sponsorId: json["_id"],
      sponsorCompany: json["companyName"],
      sponsorLogo: sponsorLogoUrl,
    );
  }
}
