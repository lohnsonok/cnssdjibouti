import 'dart:convert';

import 'package:cnss_djibouti_app/configs/ApiConnexion.dart';
import 'package:cnss_djibouti_app/models/TxnDependent.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: camel_case_types
class resulscreen extends StatefulWidget {
  final String urn;
  const resulscreen({Key? key, required this.urn}) : super(key: key);

  @override
  _resulscreenState createState() => _resulscreenState();
}

// ignore: camel_case_types
class _resulscreenState extends State<resulscreen> {
  bool isLoading = true;
  late Future<List<TxnDependent>> futureListeAssures;

  Future<List<TxnDependent>> fetchListeAssures(String compteCotisant) async {
    final response = await http.get(
        Uri.parse(ApiConnexion.baseUrl + '/txn_dependent/' + compteCotisant));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<TxnDependent>((json) => TxnDependent.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureListeAssures = fetchListeAssures(widget.urn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Espace carte Assures')),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "URN : " + widget.urn,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        valRecherche = value;
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0Xfff0f2e9),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(35.0),
                        ),
                      ),
                      hintText: "Recherche",
                    ),
                  ),
                ),*/
                  Expanded(
                    child: FutureBuilder<List<TxnDependent>>(
                      future: futureListeAssures,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "URN : ${snapshot.data![index].URN}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          "Member ID : ${snapshot.data![index].MemberID}"),
                                      SizedBox(height: 8),
                                      Text(
                                          "Member Name : ${snapshot.data![index].MemberName}"),
                                      SizedBox(height: 8),
                                      Text(
                                          "Gender : ${snapshot.data![index].Gender}"),
                                      SizedBox(height: 8),
                                      Text(
                                          "Age : ${snapshot.data![index].Age}"),
                                      SizedBox(height: 8),
                                      Text(
                                          "Dob : ${snapshot.data![index].Dob}"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          //return Center(child: CircularProgressIndicator());
                          return Center(
                              child: Text(
                                  "Aucune donnée trouvée pour ce compte : " +
                                      widget.urn));
                        }
                      },
                    ),
                  )
                ],
              )));
  }
}
