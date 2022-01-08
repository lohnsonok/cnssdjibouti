import 'dart:convert';

import 'package:cnss_djibouti_app/models/AppelCotisation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';
import 'dashboard.dart';

class AppelCotisationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppelCotisationPageState();
}

class AppelCotisationPageState extends State<AppelCotisationPage> {
  String assureurName = "";
  //String compteCotisant = "";
  String compteCotisant = "1000000000103";
  bool isLoading = true;
  late SharedPreferences preferences;
  _loadUser() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getString('nom') != null) {
      setState(() {
        assureurName = preferences.getString('nom')!;
        compteCotisant = preferences.getString('compte_cotisant')!;
      });
    }

    futureListeAppelCotisation = fetchListeAppelCotisation(compteCotisant);
  }

  late Future<List<AppelCotisation>> futureListeAppelCotisation;
  Future<List<AppelCotisation>> fetchListeAppelCotisation(
      String compte_cotisant) async {
    final response = await http.get(Uri.parse(
        ApiConnexion.baseUrl + '/appel_de_cotisation/' + compte_cotisant));
    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<AppelCotisation>((json) => AppelCotisation.fromMap(json))
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
                      "Appel de Cotisation : " + assureurName,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<AppelCotisation>>(
                      future: futureListeAppelCotisation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Color(0xff1fceed),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "N° : ${snapshot.data![index].numero_appel_de_cotisation}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/image/dues.png",
                                          width: 32,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                        "Statut de paiement : ${snapshot.data![index].statut_de_paiement}"),
                                    SizedBox(height: 8),
                                    Text(
                                        "Période : ${snapshot.data![index].periode}"),
                                    SizedBox(height: 8),
                                    Text(
                                        "Régime : ${snapshot.data![index].regime}"),
                                    SizedBox(height: 8),
                                    Text(
                                        "Multiperiode : ${snapshot.data![index].multi_periode}"),
                                    SizedBox(height: 8),
                                    Text(
                                        "Date d'échéance : ${snapshot.data![index].date_d_echeance}"),
                                    SizedBox(height: 8),
                                    Text(
                                        "Date de déclaration : ${snapshot.data![index].date_de_declaration}"),
                                  ],
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
              )));
  }
}
