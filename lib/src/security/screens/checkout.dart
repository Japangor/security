import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sc/shared/network/config.dart';
import 'package:sc/shared/utils/AppColors.dart';
import 'package:sc/src/security/utils/sidedrawerwidget.dart';
import 'package:http/http.dart' as http;
void CheckoutMain() => runApp(CheckOut());

class CheckOut extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<CheckOut> {
  String _scanBarcode = '';
  String _scanBarcode2 = '';
  bool _status = false;
  var isLoading = false;
  var remarks = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String  barcodeScanRes;
    String ? visitcode;
    String ? visitor;

    List<String> ? lines;


    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // String aStr = barcodeScanRes.replaceAll(RegExp(r'[^0-9]'),''); // '23'
      //  visitcode = barcodeScanRes.substring(0, barcodeScanRes.indexOf('EMP:'));


      lines = const LineSplitter().convert(barcodeScanRes);
      for (var i = lines.length - 1; i >= 0; i--) {
        if (lines[i].startsWith("BEGIN:VCARD") ||
            lines[i].startsWith("END:VCARD") ||
            lines[i].trim().isEmpty) {
          lines.removeAt(i);
        }
      }
      String getWordOfPrefix(String prefix) {
        //returns a word of a particular prefix from the tokens minus the prefix [case insensitive]
        for (var i = 0; i < lines!.length; i++) {
          if (lines[i].toUpperCase().startsWith(prefix.toUpperCase())) {
            String word = lines[i];
            word = word.substring(prefix.length, word.length);
            return word;
          }
        }
        return "";
      } String name = getWordOfPrefix("ORG");
      String id = getWordOfPrefix("N");
      visitor=RegExp(r'(?<=:).+').firstMatch(name)!.group(0);
      visitcode=RegExp(r'(?<=:).+').firstMatch(id)!.group(0);



      // visitcode2 = visitcode.replaceAll(RegExp(r'[^0-9]'),'');



    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if(visitor!="" && visitcode !="") {
        _scanBarcode = visitor!;
        _scanBarcode2 = visitcode!;
        _status=true;
      }
    });



  }

  // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //
  //
  //     // print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //
  //     _scanBarcode = barcodeScanRes;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Security', style: boldTextStyle(color: appTextColorPrimary)),
            ),
            drawer: SideDrawer(),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,),
                            onPressed: () => scanQR(),
                            child: const Text('Start QR scan')),

                        Text('$_scanBarcode \n $_scanBarcode2',
                            style: const TextStyle(fontSize: 20)),
                        TextField(
                          controller: remarks,

                          decoration:  const InputDecoration(
                              hintText: "Remarks"),
                          enabled:_status,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,),


                          onPressed: _status ? save : null,

                          child: const Text("Submit"),),
                      ])
              );
            })));
  }
  save() async {
    hideKeyboard(context);
    isLoading = true;
    setState(() {});

    DateTime now = DateTime.now();
    var currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);


    Map<String, String> body1 = {
      'CheckOutTime': currentTime.toString(),
      'SecurityRemark':remarks.text,
      'Sender':'security',
      'VisitorID':_scanBarcode,
    };

    final response = await
    http.post(Uri.parse(checkoutapi), body: body1);
    print(response.body);
    Map<String, dynamic> map = jsonDecode(response.body);

    toasty(context, map["message"]);

    if (response.statusCode == 200) {
      isLoading = true;
      toasty(context, "Submitted");
      finish(context);
    }

    // Map<String, dynamic> body = {'CheckOutTime': currentTime.toString(), "Sender": "visitee", "SecurityRemark": remarks.text,"VisitorID":_scanBarcode};
    //
    // Map req = {'CheckOutTime': currentTime.toString(), "Sender": "visitee", "SecurityRemark": remarks.text,"VisitorID":_scanBarcode};
    //
    // await checkout(body).then((value) {
    //
    //   isLoading = true;
    //   toasty(context, value['message']);
    //
    //   finish(context);
    // }).catchError((e) {
    //   isLoading = false;
    //   toasty(context, e.toString());
    // });


    setState(() {});
  }

}
