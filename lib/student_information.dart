import 'dart:convert';
import 'package:flutter_csdl/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StudentInformation extends StatefulWidget {
  final String studentId;
  const StudentInformation({Key? key, required this.studentId}) : super(key: key);

  @override
  _StudentInformationState createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  late ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
  var _studentFullName = "";
  var _studentImageFileName = "";
  void getStudentInformation() async {
    try {
      String studentId = widget.studentId;
      Map<String, String> jsonData = {
        "studId": studentId,
      };

      Map<String, String> requestBody = {
        "operation": "getStudentInformation",
        "json": jsonEncode(jsonData),
      };

      var res = await http.post(
        Uri.parse("${SessionStorage.url}users.php"),
        body: requestBody,
      );

      if (res.body != "0") {
        print("res.body = " + res.body);
        Map<String, dynamic> jsonRes = jsonDecode(res.body);
        setState(() {
          _studentFullName = jsonRes["stud_fullName"].toString();
          _studentImageFileName = jsonRes["stud_image"].toString();
        });
        print("_studentFullName: " + _studentFullName);
        print("_studentImageFileName: " + _studentImageFileName);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getStudentInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("assets/images/$_studentImageFileName"),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _studentFullName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
