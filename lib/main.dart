import 'dart:convert';

import 'package:flutter/material.dart';
import './models/PostOffice.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Mypp());
}

class Mypp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final pincodeController = TextEditingController();
  //final navigatorKey = GlobalKey<NavigatorState>();
  List<Postoffice> arr = [];
  String city = "City";
  String name = "Name";
  String country = "Country";
  String state = "State";
  bool _isloading = false;
  void call(
      String nam, String circe, String county, String stae, BuildContext cont) {
    print("$nam $circe $county $stae");
    setState(() {
      city = circe;
      country = county;
      state = stae;
      name = nam;
    });
    Navigator.pop(cont);
  }

  void onSave(String value) async {
    print("heree too");

    final response =
        await http.get('https://api.postalpincode.in/pincode/' + value);
    print(response);
    List<dynamic> listData = json.decode(response.body)[0]['PostOffice'];
    arr.clear();
    for (int i = 0; i < listData.length; i++) {
      arr.add(Postoffice(
          country: listData[i]['Country'],
          name: listData[i]['Name'],
          circle: listData[i]['Block'],
          state: listData[i]['State']));
    }
    print(arr);
  }

  void dialogue(BuildContext context, value) async {
    await onSave(
      value,
    );
    showDialog(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (builder, setState) {
              return AlertDialog(
                content: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width - 30,
                  child: ListView.builder(
                    itemBuilder: (c, index) {
                      return InkWell(
                        onTap: () => call(arr[index].name, arr[index].circle,
                            arr[index].country, arr[index].state, ctx),
                        hoverColor: Colors.green,
                        focusColor: Colors.green,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Text(
                              arr[index].name,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: arr.length,
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  key: navigatorKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Post office"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (builder, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            // color: Colors.yellow[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //  color: Colors.red,
                  height: constraints.maxHeight / 8,
                  width: constraints.maxWidth - 40,
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    //  controller: pincodeController,
                    onChanged: (text) {
                      setState(() {
                        arr.clear();
                        city = "City";
                        country = "Country";
                        name = "Name";
                        state = "State";
                      });
                    },
                    onSubmitted: (text) async {
                      print("entering here");
                      dialogue(context, text);
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: "Search pincode",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: constraints.maxHeight / 8,
                          width: constraints.maxWidth / 2,
                          child: LayoutBuilder(
                            builder: (context, innerconst) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(innerconst.maxWidth * 0.05),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      city,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(
                                          innerconst.maxWidth * 0.08)),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight / 8,
                          width: constraints.maxWidth / 2,
                          child: LayoutBuilder(
                            builder: (context, innerconst) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(innerconst.maxWidth * 0.05),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      country,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(
                                          innerconst.maxWidth * 0.08)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: constraints.maxHeight / 8,
                          width: constraints.maxWidth / 2,
                          child: LayoutBuilder(
                            builder: (context, innerconst) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(innerconst.maxWidth * 0.05),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(
                                          innerconst.maxWidth * 0.08)),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight / 8,
                          width: constraints.maxWidth / 2,
                          child: LayoutBuilder(
                            builder: (context, innerconst) {
                              return Padding(
                                padding:
                                    EdgeInsets.all(innerconst.maxWidth * 0.05),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      state,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(
                                          innerconst.maxWidth * 0.08)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
