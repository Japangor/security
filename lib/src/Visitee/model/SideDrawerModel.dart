import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerModel {
  String? title;
  IconData? icon;
  Widget? goto;
  bool isSelected;

  DrawerModel({this.title, this.icon, this.goto, this.isSelected = false});
}
Widget createBasicListTile({IconData? icon, required String text, Function? onTap}) {
  return ListTile(
    contentPadding: EdgeInsets.all(0),
    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
    onTap: onTap as void Function()?,
    title: Text(text, style: TextStyle(fontSize: 16)),
    leading: Icon(icon, color: Colors.black, size: 22),
  );
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4), size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

