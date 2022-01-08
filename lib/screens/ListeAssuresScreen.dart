import 'dart:convert';

import 'package:cnss_djibouti_app/models/CotisantAssure.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';
import 'dashboard.dart';

class ListeAssuresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListeAssuresPageState();
}

class ListeAssuresPageState extends State<ListeAssuresPage> {
  String assureurName = "";
  String compteCotisant = "";
  bool isLoading = true;

  String valRecherche = "";

  late SharedPreferences preferences;
  _loadUser() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getString('nom') != null) {
      setState(() {
        assureurName = preferences.getString('nom')!;
        compteCotisant = preferences.getString('compte_cotisant')!;
      });

      futureListeAssures = fetchListeAssures(compteCotisant);
    }
  }

  late Future<List<CotisantAssure>> futureListeAssures;

  Future<List<CotisantAssure>> fetchListeAssures(String compteCotisant) async {
    final response = await http.get(Uri.parse(
        ApiConnexion.baseUrl + '/relation-cotisant-assure/' + compteCotisant));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<CotisantAssure>((json) => CotisantAssure.fromMap(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CNSS-Djibouti'),
          centerTitle: true,
          leading: Builder(
            builder: (context) => BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(),
                  ),
                );
              },
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Liste des assurés de : " + assureurName,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      onChanged: (value) {
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
                  ),
                  Expanded(
                    child: FutureBuilder<List<CotisantAssure>>(
                      future: futureListeAssures,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) {
                              return snapshot.data![index].nomAssure!
                                      .toLowerCase()
                                      .contains(valRecherche)
                                  ? Container(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xff1fceed),
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Numero Assuré : ${snapshot.data![index].compte_assure}",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                                "Nom assuré : ${snapshot.data![index].nomAssure}"),
                                            SizedBox(height: 8),
                                            Text(
                                                "SSN : ${snapshot.data![index].SSN}"),
                                            SizedBox(height: 8),
                                            Text(
                                                "Salaire Brut : ${snapshot.data![index].salaire}"),
                                            SizedBox(height: 8),
                                            Text(
                                                "Date d'embauche : ${snapshot.data![index].date_d_embauche}"),
                                            // SizedBox(height: 8),
                                            // Text(
                                            //     "Matricule externe : ${snapshot.data![index].matricule_externe}"),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          );
                        } else {
                          //return Center(child: CircularProgressIndicator());
                          return Center(
                              child: Text(
                                  "Aucun donnée trouvée pour ce compte : " +
                                      compteCotisant));
                        }
                      },
                      /*Center(
          child: Column(
            children: [
            Container(
              margin: EdgeInsets.all(20),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID', style: TextStyle(fontSize: 18))),
                  DataColumn(label: Text('ID', style: TextStyle(fontSize: 18))),
                  DataColumn(label: Text('ID', style: TextStyle(fontSize: 18))),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('1')),
                    DataCell(Text('1')),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('1')),
                    DataCell(Text('1')),
                  ]),

                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text('1')),
                    DataCell(Text('1')),
                  ]),
                ],
              )
            )
          ],
          ),
        ),*/
                    ),
                  )
                ],
              )));
  }
}
