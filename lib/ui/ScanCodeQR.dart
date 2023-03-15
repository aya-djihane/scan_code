import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan_code/services/verificationServices.dart';
class ScanCode extends StatefulWidget {
  const ScanCode({Key? key}) : super(key: key);
  @override
  State<ScanCode> createState() => _ScanCodeState();
}
class _ScanCodeState extends State<ScanCode> {
  final GlobalKey qrKey =GlobalKey();
  QRViewController? controller;
  Barcode? result;
  var data;
  void qr(QRViewController controller){
    this.controller = controller;
    VerificationServices verificationServices = VerificationServices();
    controller.scannedDataStream.listen((event)async {
   data = await verificationServices.Verify(event.code);
      setState(() {
        result = event;
        data = data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      body: Center(
       child : Column(
         children:<Widget> [
           Container(
             height: 400,
             width: 400,
             child :QRView(
               key: qrKey,
               onQRViewCreated: qr,
             )
           ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
              child: Container (
                height: 100,
                 color:data!=null&&data==true? Colors.green :Colors.red,
                child: Center(child: Text (data!=null&&data==true?'Allow ':'Denied',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),))
              ),
            )

         ],

       )
      ),
    )
    );
  }
}
