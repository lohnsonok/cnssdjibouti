import 'dart:convert';

import 'package:cnss_djibouti_app/animations/fade_animation.dart';
import 'package:cnss_djibouti_app/models/AppelCotisation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';
import 'dashboard.dart';

class AppelCotisationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppelCotisationPageState();
}

class AppelCotisationPageState extends State<AppelCotisationPage> {
  List<dynamic> appelsCotisationList = [];
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
    appelsCotisationList = await futureListeAppelCotisation;
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
        leading: IconButton(
            padding: EdgeInsets.only(left: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey.shade600,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.grey.shade400,
                )),
          )
        ],
        title: Container(
          height: 45,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none),
                hintText: "Rechercher",
                hintStyle: TextStyle(fontSize: 14, fontFamily: "Lato"),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: appelsCotisationList.length,
                itemBuilder: (context, index) {
                  return FadeAnimation((1.0 + index) / 4,
                      itemWidget(appelCotisation: appelsCotisationList[index]));
                }),
      ),
    );
  }

  itemWidget({required AppelCotisation appelCotisation}) {
    final f = new DateFormat('dd-MM-yyyy');

    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ]),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(children: [
                        Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appelCotisation.nom ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(appelCotisation.periode ?? "",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: "Lato")),
                              ]),
                        )
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: getStatusColor(
                                appelCotisation.statut_de_paiement)),
                        child: Text(
                          getStatus(appelCotisation.statut_de_paiement),
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Lato"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Régime:",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                appelCotisation.regime ?? "",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Compte cotisant:",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                appelCotisation.compte_cotisant ?? "",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Appel de cotisation:",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                appelCotisation.numero_appel_de_cotisation ??
                                    "",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Lato"),
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Multi période:",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  appelCotisation.multi_periode ?? "",
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Date d'échéance:",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  f.format(DateTime.parse(appelCotisation
                                      .date_d_echeance
                                      .toString()
                                      .substring(0, 10))),
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Date de déclaration:",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  f.format(DateTime.parse(appelCotisation
                                      .date_de_declaration
                                      .toString()
                                      .substring(0, 10))),
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: "Lato"),
                                ),
                              ])
                        ])
                  ],
                ),
              )
            ],
          ),
        ));
  }

  getStatusColor(statut) {
    if (statut == "Payé") {
      return Color(int.parse("0xFF00CDAF")).withAlpha(20);
    } else if (statut == "Non Payé") {
      return Color(int.parse("0xFFFF0000")).withAlpha(20);
    } else {
      return Color(int.parse("0xFFABB6C0")).withAlpha(20);
    }
  }

  getStatus(statut) {
    if (statut == "Payé") {
      return "Payé";
    } else if (statut == "Non Payé") {
      return "Non Payé";
    } else {
      return "Paiement en cours";
    }
  }
}
