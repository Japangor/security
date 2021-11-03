
class visiteeprofile {

  final String VisiteeName;

  final String Photo;


  visiteeprofile({

    required this.VisiteeName,

    required this.Photo,

  });

  factory visiteeprofile.fromJson(Map<String, dynamic> json) {
    return visiteeprofile(

      VisiteeName: json['VisiteeName'],

      Photo: json['Photo'],

    );
  }
}