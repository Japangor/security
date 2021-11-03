
class securityprofile {

  final String SecurityCompanyName;
  final String SecurityPersonnelName;
  final String MobileNo;
  final String Email;
  final String Photo;
  final String Address;

  securityprofile({

    required this.SecurityCompanyName,
    required this.SecurityPersonnelName,
    required this.MobileNo,

    required this.Email,
    required this.Photo,
    required this.Address,

  });

  factory securityprofile.fromJson(Map<String, dynamic> json) {
    return securityprofile(

      SecurityCompanyName: json['SecurityCompanyName'],
      SecurityPersonnelName: json['SecurityPersonnelName'],
      MobileNo: json['MobileNo'],
      Email: json['Email'],
      Photo: json['Photo'],
      Address: json['Address'],

    );
  }
}