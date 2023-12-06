import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:qr/qr.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String firstname = "";
  late String middlename = "";
  late String lastname = "";
  late String idNumber = "";
  late String course = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "CSDL Q.R CODE GENERATOR",
              style: TextStyle(
                fontSize: 100.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            // YourWidgetB(name: firstname),
            SizedBox(height: 50),
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      firstname = value;
                    },
                  );
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "First Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none),
              ),
            ),
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      middlename = value;
                    },
                  );
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Middle Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none),
              ),
            ),
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      ;
                      lastname = value;
                    },
                  );
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Last Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none),
              ),
            ),
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      course = value;
                    },
                  );
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Course",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none),
              ),
            ),
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      idNumber = value;
                    },
                  );
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "I.D Number",
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            RawMaterialButton(
              fillColor: Colors.white,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(
                horizontal: 36.0,
                vertical: 16.0,
              ),
              child: Text("Generate QR Code"),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return QRCodeGenerator(
                      firstname: firstname,
                      middlename: middlename,
                      lastname: lastname,
                      idNumber: idNumber,
                      course: course,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QRCodeGenerator extends StatefulWidget {
  final String firstname;
  final String middlename;
  final String lastname;
  final String idNumber;
  final String course;

  QRCodeGenerator(
      {required this.firstname,
      required this.middlename,
      required this.lastname,
      required this.idNumber,
      required this.course});

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  // You can access widget.name here

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Q.R CODE",
          style: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
            backgroundColor: Colors.white,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: QrImageView(
            data:
                '${widget.firstname} ${widget.middlename} ${widget.lastname} ${widget.course} ${widget.idNumber}',
            backgroundColor: Colors.white,
            size: 200.0,
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _saveQrCode(
            widget.firstname,
            widget.middlename,
            widget.lastname,
            widget.idNumber,
            widget.course,
          ),
          child: Text('Download QR Code'),
        ),
      ],
    );
  }

  Future<void> _saveQrCode(
    String firstname,
    String middlename,
    String lastname,
    String idNumber,
    String course,
  ) async {
    try {
      // Save the image to the device's gallery
      final result = await ImageGallerySaver.saveFile(
        'data:image/png;base64,' +
            generateQrCodeBase64(
                firstname, middlename, lastname, idNumber, course),
      );

      print("Image saved: $result");
    } catch (e) {
      print("Error: $e");
    }
  }

  String generateQrCodeBase64(
    String firstname,
    String middlename,
    String lastname,
    String idNumber,
    String course,
  ) {
    final data = '$firstname $middlename $lastname $course $idNumber';
    // Generate QR code and encode it to base64
    return base64Encode(Uint8List.fromList(utf8.encode(data)));
  }
}