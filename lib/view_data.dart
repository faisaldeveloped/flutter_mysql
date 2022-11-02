import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_app/update_data.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];

  Future<void> deleteData(String id) async {
    try {
      String uri = "http://192.168.182.1:8080/myDatabase_api/delete_data.php";

      var res = await http.post(Uri.parse(uri), body: {'id': id});

      var response = jsonDecode(res.body);

      if (response["success"] == "true") {
        print("Data Deleted");
        getRecord();
      } else {
        print("Some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getRecord() async {
    String uri = "http://192.168.182.1:8080/myDatabase_api/view_data.php";

    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Data"),
      ),
      body: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateData(
                          userData[index]["name"],
                          userData[index]["email"],
                          userData[index]["password"]),
                    ),
                  );
                },
                leading: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.red,
                ),
                title: Text(userData[index]["name"]),
                subtitle: Text(userData[index]["email"]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteData(userData[index]['id']);
                  },
                ),
              ),
            );
          }),
    );
  }
}
