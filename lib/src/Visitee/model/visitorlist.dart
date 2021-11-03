
class visitorlistmodelvisitee {

  final String VisitorID;
  final String VisiteeName;
  final String VisitorPhoto;
  final String Submitted;
  final String CheckInTime;
  final String CheckOutTime;
  final String VisitPurpose;
  final String VisitorName;
  final String VisitorLocation;

  final String MobileNo;
  final String AddVisitors;
  final String CompanyName;
  final String PlantName;
  final String SecurityGateName;
  final String DepartmentName;
  final String VisitorType;
  final String VisitOutTime;
  final String VisiteeRemark;
  final String SecurityRemark;

  visitorlistmodelvisitee({

    required this.VisitorID,
    required this.VisiteeName,
    required this.VisitorPhoto,
    required this.Submitted,
    required this.CheckInTime,
    required this.CheckOutTime,

    required this.VisitorName,
    required this.VisitorLocation,
    required this.VisitPurpose,


    required this.MobileNo,
    required this.AddVisitors,
    required this.CompanyName,
    required this.PlantName,
    required this.SecurityGateName,
    required this.DepartmentName,
    required this.VisitorType,
    required this.VisitOutTime,
    required this.VisiteeRemark,
    required this.SecurityRemark,

  });

  factory visitorlistmodelvisitee.fromJson(Map<String, dynamic> json) {
    return visitorlistmodelvisitee(

      VisitorID: json['VisitorID'],
      VisiteeName: json['VisiteeName'],
      VisitorPhoto: json['VisitorPhoto'],
      VisitorName: json['VisitorName'],
      Submitted: json['Submitted'],
      CheckInTime: json['CheckInTime'],
      CheckOutTime: json['CheckOutTime'],
      VisitorLocation: json['VisitorLocation'],
      VisitPurpose: json['VisitPurpose'],


      MobileNo: json['MobileNo'],
      AddVisitors: json['AddVisitors'],
      CompanyName: json['CompanyName'],
      PlantName: json['PlantName'],
      SecurityGateName: json['SecurityGateName'],
      DepartmentName: json['DepartmentName'],
      VisitorType: json['VisitorType'],
      VisitOutTime: json['VisitOutTime'],
      VisiteeRemark: json['VisiteeRemark'],
        SecurityRemark:json['SecurityRemark'],
      // SecurityPersonnelName: json['SecurityPersonnelName'],
      // MobileNo: json['MobileNo'],
      // Email: json['Email'],
      // Photo: json['Photo'],
      // Address: json['Address'],

    );
  }
}