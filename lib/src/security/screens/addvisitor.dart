import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_capture_field/image_capture_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:sc/src/security/model/addvisitormodel.dart';
import 'package:sc/shared/network/config.dart';
import 'package:sc/shared/network/rest_apis.dart';

import '../utils/sidedrawerwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/utils/AppColors.dart';
import 'package:http/http.dart'as http;

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
class addvisitor extends StatefulWidget {
  @override
  addvisitorScreenState createState() => addvisitorScreenState();
}

class addvisitorScreenState extends State<addvisitor> {
  int currentIndex = 0;
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;


  List<visitortype> types = [];
    visitortype ? selectedtype;

  List<planttype> plant = [];
  planttype ? selectedplant;

  List<persontomeetmodel> visitee = [];
  persontomeetmodel ? selectedvisitee;

  gatemodel ? selectedgate;
  List<gatemodel> gates = [];

  departmentmodel ? selecteddepartment;
  List<departmentmodel> department = [];
  late String  additional;
  late String secuirtyid;

  var visitorname = TextEditingController();
  var visitormobile = TextEditingController();
  var companyname = TextEditingController();
  var visitorfrom = TextEditingController();
  var purpose = TextEditingController();
  var others = TextEditingController();
  String? path;

  var formKey = GlobalKey<FormState>();
  var autoValidate = false;
  var isLoading = false;
  @override
  void initState() {
    super.initState();

    getvisitortype(visitortypeapi).then((List<visitortype> value) {
      setState(() {
        types = value;
      });
    });
    getplants(plantapi).then((List<planttype> value) {
      setState(() {
        plant = value;
      });
    });
    getpersontomeet(persontomeet).then((List<persontomeetmodel> value) {
      setState(() {
        visitee = value;
      });
    });
    init();
  }

  void onvtypeChange(state) {
    setState(() {
      selectedtype = state;

      print(selectedtype?.VisitorTypeID);


    });

  }
  void onplanttypeChange(state) {
    setState(() {
      selectedplant = state;
      gates = [];
      selectedgate = null;
      department = [];
      selecteddepartment = null;

    });
    getgate(gateapi+'?PlantID='+selectedplant!.PlantID).then((List<gatemodel> value) {
      setState(() {
        gates = value;
      });
    });
    getdepartment(departmentapi+'?PlantID='+selectedplant!.PlantID).then((List<departmentmodel> value) {
      setState(() {
        department = value;
      });
    });


  }
  void onvisiteeChange(state) {
    setState(() {
      selectedvisitee = state;

    });
  }
  void ongateChange(state) {
    setState(() {
      selectedgate = state;
    });
  }
  void ondepartmentchange(state) {
    setState(() {
      selecteddepartment = state;
    });
  }

  init() async {
    visitorname=visitorname.text as TextEditingController;
    visitormobile=visitormobile.text as TextEditingController;
    companyname=companyname.text as TextEditingController;
    visitorfrom=visitorfrom.text as TextEditingController;
    purpose=purpose.text as TextEditingController;
    others=others.text as TextEditingController;

    //
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    key: _formKey;
    DateTime now = DateTime.now();
    var currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);



    void onadditional(state) {
      setState(() {

        additional = state;
        print(additional);
      });
    }

    save() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      secuirtyid = (prefs.getString('SecurityID') ?? "");
      hideKeyboard(context);

        isLoading = true;
        setState(() {});

        Map req = {"VisitorName": visitorname.text, "SecurityID": secuirtyid.toString(), "MobileNo": visitormobile.text,"AddVisitors":additional,"CompanyName":companyname.text,"VisitorLocation":visitorfrom.text,"VisitorType":selectedtype!.VisitorTypeID,"Visitee":selectedvisitee!.VisiteeID,"VisitPurpose":purpose.text,"CheckInTime":currentTime.toString(),"Mobile":valuefirst,"Laptop":valuesecond,"ToolKits":valuethird,"OtherCarrying":others.text,"file":"gsgs"};
      Response response;
      var dio = Dio();
      dio.options.contentType = 'application/json';



      var formData = FormData.fromMap(
          {
            "VisitorName": visitorname.text, "SecurityID": secuirtyid.toString(), "MobileNo": visitormobile.text,"AddVisitors":additional,"CompanyName":companyname.text,"VisitorLocation":visitorfrom.text,"VisitorType":selectedtype!.VisitorTypeID,"Visitee":selectedvisitee!.VisiteeID,"VisitPurpose":purpose.text,"CheckInTime":currentTime.toString(),"Mobile":valuefirst,"Laptop":valuesecond,"ToolKits":valuethird,"OtherCarrying":others.text,
          'file': await MultipartFile.fromFile(path!, filename: DateTime.now().toIso8601String(),contentType: MediaType("image", "jpeg")
          ),
          }



      );



       response = await dio.post(visitors, data: formData,);
       print(response.data.toString());


      //
      // final response = await
      // http.post(Uri.parse(visitors), body: req);
      // print(response.body);
      // Map map = jsonDecode(response.body);
      //
      // toasty(context, map["message"]);

        //
        // await postvisitor(req).then((value) {
        //
        //   isLoading = false;
        //   toasty(context, value['message']);
        //
        //   finish(context);
        // }).catchError((e) {
        //   isLoading = false;
        //   toasty(context, e.toString());
        // });


      setState(() {});
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('Add Visitor', style: boldTextStyle(color: appTextColorPrimary)),
      ),
      drawer: SideDrawer(),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    elevation: 16,
                    child: Container(
                      child: ListView(
                        shrinkWrap: true,
                        children:  <Widget>[
                          SizedBox(height: 20),
                          ElevatedButton(onPressed: () async {
                            List<Media>? res = await ImagesPicker.pick(
                              count: 1,
                              pickType: PickType.image,
                              language: Language.System,
                              // maxSize: 500,
                              cropOpt: CropOption(
                                aspectRatio: CropAspectRatio.wh16x9,
                              ),
                            );
                            if (res != null) {
                              print(res.map((e) => e.path).toList());
                              setState(() {
                                path = res[0].thumbPath;
                              });
                              // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
                              // print(status);
                            }
                          },
                            child: Text("From Gallery"),),
                          ElevatedButton(
                            child:  Text('From Camera'),
                            onPressed: () async {
                              List<Media>? res = await ImagesPicker.openCamera(
                                pickType: PickType.image,
                                // quality: 0.5,
                                cropOpt: CropOption(
                                  aspectRatio: CropAspectRatio.wh16x9,
                                ),
                                maxTime: 15,
                              );
                              if (res != null) {
                                print(res[0].path);
                                setState(() {
                                  path = res[0].thumbPath;
                                });
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text('Select Image'),
          ),

          path != null
              ? Container(
            height: 200,
            child: Image.file(
              File(path!),
              fit: BoxFit.contain,
            ),
          )
              : SizedBox.shrink(),

          TextFormField(
            controller: visitorname,

            decoration: const InputDecoration(
              prefixIcon:  Icon(Icons.person),
              hintText: 'Visitor Name',
              labelText: 'Visitor Name',
            ),
          ),
          DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
              ),
              hint: const Text("Select Number of Visitor"),
              items: <String>['0', '1', '2', '3','4','5','6','7','8','9','10'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged:
                onadditional

          ),
          TextFormField(
            controller: visitormobile,

            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: 'Visitor Mobile ',
              labelText: 'Visitor Mobile ',
            ),
          ),

          TextFormField(
            controller: companyname,

            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.group_work),
              hintText: 'Company Name',
              labelText: 'Company Name',
            ),
          ),
          TextFormField(
            controller: visitorfrom,

            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.group_work),
              hintText: 'Visitor From',
              labelText: 'Visitor From',
            ),
          ),
          DropdownButtonFormField<visitortype>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
            ),
            hint: const Text('Visitor Type'),
            isExpanded: true,
            value: selectedtype,

            items: types.map((visitortype typename) {
              return DropdownMenuItem<visitortype>(
                value: typename,
                child: Text(typename.VisitorType),
              );
            }).toList(),
            onChanged: onvtypeChange,
          ),
          DropdownButtonFormField<planttype>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
            ),
            hint: const Text('Select Plant '),
            isExpanded: true,
            value: selectedplant,

            items: plant.map((planttype typename) {
              return DropdownMenuItem<planttype>(
                value: typename,
                child: Text(typename.PlantName),
              );
            }).toList(),
            onChanged: onplanttypeChange,
          ),
          DropdownButtonFormField<persontomeetmodel>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
            ),
            hint: const Text('Select Person to meet '),
            isExpanded: true,
            value: selectedvisitee,

            items: visitee.map((persontomeetmodel typename) {
              return DropdownMenuItem<persontomeetmodel>(
                value: typename,
                child: Text(typename.VisiteeName),
              );
            }).toList(),
            onChanged: onvisiteeChange,
          ),
          DropdownButtonFormField<gatemodel>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
            ),
            hint: const Text('Select Security Gate'),
            value: selectedgate,
            isExpanded: true,
            items: gates.map((gatemodel gate) {
              return DropdownMenuItem<gatemodel>(
                value: gate,
                child: Text(gate.SecurityGateName),
              );
            }).toList(),
            onChanged: ongateChange,
          ),
          DropdownButtonFormField<departmentmodel>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
            ),
            hint: const Text('Select Department'),
            value: selecteddepartment,
            isExpanded: true,
            items: department.map((departmentmodel department) {
              return DropdownMenuItem<departmentmodel>(
                value: department,
                child: Text(department.DepartmentName),
              );
            }).toList(),
            onChanged: ondepartmentchange,
          ),
          TextFormField(
            controller: purpose,

            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.group_work),
              hintText: 'Purpose Of Visit',
              labelText: 'Purpose Of Visit',
            ),
          ),
           Text('CheckIn Time: $currentTime',style: TextStyle(fontSize: 17.0), ),


          const Text('Carrying: ',style: TextStyle(fontSize: 17.0), ),

          Row(
              children: <Widget>[
                const SizedBox(width: 10,),
                const Text('Laptop: ',style: TextStyle(fontSize: 17.0), ),
                Checkbox(

                  checkColor: Colors.greenAccent,
                  activeColor: Colors.red,
                  value: valuefirst,
                  onChanged: (bool? value) {
                    setState(() {
                      valuefirst = value!;
                    });
                  },
                ),
                const Text('Mobile: ',style: TextStyle(fontSize: 17.0), ),

                Checkbox(
                  checkColor: Colors.greenAccent,
                  activeColor: Colors.red,
                  value: valuesecond ,
                  onChanged: (bool? value) {
                    setState(() {
                      valuesecond  = value!;
                    });
                  },
                ),
                const Text('Toolkits: ',style: TextStyle(fontSize: 17.0), ),

                Checkbox(
                  checkColor: Colors.greenAccent,
                  activeColor: Colors.red,
                  value: valuethird ,
                  onChanged: (bool? value) {
                    setState(() {
                      valuethird  = value!;
                    });
                  },
                ),
              ]),
          TextFormField(
            controller: others,

            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.group_work),
              hintText: 'Others',
              labelText: 'Others',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print(path);
              save();

            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

}
