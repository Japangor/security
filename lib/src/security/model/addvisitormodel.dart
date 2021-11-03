import 'package:flutter/src/material/dropdown.dart';

class visitortype {
  final String VisitorType;
  final String VisitorTypeID;

  visitortype({
    required this.VisitorType,
    required this.VisitorTypeID,

  });

  factory visitortype.fromJson(Map<String, dynamic> json) {
    return visitortype(
      VisitorType: json['VisitorType'],
      VisitorTypeID: json['VisitorTypeID'],

    );
  }

}
class planttype {
  final String PlantName;
  final String PlantID;


  planttype({
    required this.PlantID,
    required this.PlantName,


  });

  factory planttype.fromJson(Map<String, dynamic> json) {
    return planttype(
      PlantName: json['PlantName'],
      PlantID: json['PlantID'],


    );
  }

}
class persontomeetmodel {
  final String VisiteeName;
  final String VisiteeID;

  persontomeetmodel({
    required this.VisiteeID,
    required this.VisiteeName,

  });

  factory persontomeetmodel.fromJson(Map<String, dynamic> json) {
    return persontomeetmodel(
      VisiteeName: json['VisiteeName'],
      VisiteeID: json['VisiteeID'],

    );
  }

}
class gatemodel {
  final String SecurityGateID;
  final String SecurityGateName;

  gatemodel({
    required this.SecurityGateID,
    required this.SecurityGateName,

  });

  factory gatemodel.fromJson(Map<String, dynamic> json) {
    return gatemodel(
      SecurityGateID: json['SecurityGateID'],
      SecurityGateName: json['SecurityGateName'],


    );
  }

}
class departmentmodel {
  final String DepartmentID;
  final String DepartmentName;

  departmentmodel({
    required this.DepartmentID,
    required this.DepartmentName,

  });

  factory departmentmodel.fromJson(Map<String, dynamic> json) {
    return departmentmodel(
      DepartmentID: json['DepartmentID'],
      DepartmentName: json['DepartmentName'],


    );
  }

}