class company {
  final String CompanyName;
  final String CompanyDesc;
  final String Address;
  final String Email;
  final String Phone;
  final String Fax;
  final String WebAddress;



  company({
    required this.CompanyName,
    required this.CompanyDesc,
    required this.Address,
    required this.Email,
    required this.Phone,
    required this.Fax,
    required this.WebAddress,


  });

  factory company.fromJson(Map<String, dynamic> json) {
    return company(
      CompanyName: json['CompanyName'],
      CompanyDesc: json['CompanyDesc'],
      Address: json['Address'],
      Email: json['Email'],
      Phone: json['Phone'],
      Fax: json['Fax'],
      WebAddress: json['WebAddress'],

    );
  }
}