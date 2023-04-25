import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../../../constants/constant.dart';

class Fav extends StatefulWidget {
  const Fav({Key? key}) : super(key: key);

  @override
  State<Fav> createState() => _FavState();
}

class _FavState extends State<Fav> {
  static Future fetchExperts() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/show_Favorites/1'),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('success');
      print(response.body);
      return responseBody;
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: fetchExperts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return SizedBox(
                  child: SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: snapshot.data["favorites"].length,
                      itemBuilder: (BuildContext context, int index) {
                        print(snapshot.data["favorites"][index]["name"]);
                        print(
                          snapshot.data["favorites"][index]["session_price"],
                        );
                        print(
                          snapshot.data["favorites"][index]["experiences"],
                        );

                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.height / 8,
                            child: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Container(
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/doctor.jpg"),
                                              fit: BoxFit.cover),
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: 60,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data["favorites"][index]
                                                  ["name"],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'headLine'),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  12,
                                            ),
                                            Text(
                                              snapshot.data["favorites"][index]
                                                      ["session_price"]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.indigo.shade900,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        //"experiences"
                                        Text(
                                          snapshot.data["favorites"][index]
                                              ["experiences"],
                                          style: TextStyle(
                                              color: Colors.indigo.shade900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
