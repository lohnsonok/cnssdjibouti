import 'dart:convert';

import 'package:cnss_djibouti_app/models/Communique.dart';
import 'package:cnss_djibouti_app/widget/appdrawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';

class CommuniquesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommuniquesPageState();
}

class CommuniquesPageState extends State<CommuniquesPage> {
  bool isLoading = true;

  late Future<List<Communique>> futureListeCommuniques;

  Future<List<Communique>> fetchListeCommuniques() async {
    final response =
        await http.get(Uri.parse(ApiConnexion.baseUrl + '/communiques'));
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<Communique>((json) => Communique.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureListeCommuniques = fetchListeCommuniques();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CNSS-Djibouti'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
              children: [
                /*Padding(padding: EdgeInsets.all(20),
                  child: Text("Liste des assurés de : " + assureurName,textAlign: TextAlign.center ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),
                */
                Expanded(
                  child: FutureBuilder<List<Communique>>(
                    future: futureListeCommuniques,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Card(
                                margin: EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 12.0, left: 12.0, right: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color:
                                                  AppTheme.randomColor(context),
                                            ),
                                            child: Image.asset(
                                              "assets/images/logo.jpg",
                                              fit: BoxFit.fill,
                                              width: 40,
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  new Text(
                                                      "${snapshot.data![index].title}"),
                                                  new Text(
                                                      "${snapshot.data![index].created_at}")
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  "${snapshot.data![index].body}" ==
                                                          ""
                                                      ? Text('')
                                                      : Text(
                                                          "${snapshot.data![index].body}"),
                                                  //Text(date)
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(''),
                                                  //isNull(date) ? Text('') : Text(date)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ),
                        );
                      } else {
                        //return Center(child: CircularProgressIndicator());
                        return Center(child: Text("Aucun donnée trouvée"));
                      }
                    },
                  ),
                )
              ],
            )),
      drawer: AppDrawer(),
    );
  }
}
