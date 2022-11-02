import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_app/view_data.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertRecord() async {
    if (name.text != "" || email.text != "" || password.text != "") {
      try {
        String uri =
            "http://192.168.182.1:8080/myDatabase_api/insert_record.php";

        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text,
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("Record Inserted");
          name.text = "";
          email.text = "";
          password.text = "";
        } else {
          print("Some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All fileds");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MySQLg"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the name"),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the email"),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the password"),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  insertRecord();
                },
                child: const Text("Insert"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewData()));
                      },
                      child: const Text("View Data"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
