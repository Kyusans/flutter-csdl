import 'package:flutter/material.dart';
import 'package:flutter_csdl/qrcode.dart';
import 'package:flutter_csdl/student_information.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(
                        isShowFlashIcon: true,
                        cancelButtonText: "Back",
                        lineColor: "green",
                      ),
                    ),
                  );
                  setState(() {
                    if (res is String) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              StudentInformation(studentId: res),
                        ),
                      );
                    }
                  });
                },
                child: const Text('Open Scanner'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                child: const Text("Generate QR code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
