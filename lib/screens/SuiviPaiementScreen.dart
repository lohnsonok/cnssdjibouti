import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:cnss_djibouti_app/animations/fade_animation.dart';
import 'package:cnss_djibouti_app/models/SuiviPaiement.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';
import 'dashboard.dart';

const double _fabDimension = 56.0;

class SuiviPaiementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SuiviPaiementPageState();
}

class SuiviPaiementPageState extends State<SuiviPaiementPage> {
  List<dynamic> recouvrementList = [];

  String assureurName = "";
  //String compteCotisant = "";
  String compteCotisant = "";
  bool isLoading = true;
  bool isFiltered = false;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }

  late SharedPreferences preferences;
  _loadUser() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getString('nom') != null) {
      setState(() {
        assureurName = preferences.getString('nom')!;
        compteCotisant = preferences.getString('compte_cotisant')!;
      });
      futureListeRecouvrement = fetchListeRecouvrement(compteCotisant);
      recouvrementList = await futureListeRecouvrement;
      /* recouvrementList = recouvrementList
          .where((element) => element.statut == "Declaré")
          .toList(); */
    }
  }

  late Future<List<SuiviPaiement>> futureListeRecouvrement;
  Future<List<SuiviPaiement>> fetchListeRecouvrement(
      String compteCotisant) async {
    final response = await http
        .get(Uri.parse(ApiConnexion.baseUrl + '/suivi/' + compteCotisant));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<SuiviPaiement>((json) => SuiviPaiement.fromMap(json))
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
                onPressed: () {
                  isFiltered = !isFiltered;
                  _filterRecouvrementList();
                },
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.grey.shade400,
                )),
          )
        ],
        title: Container(
          height: 45,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Suivi de paiement",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: recouvrementList.length,
                itemBuilder: (context, index) {
                  return FadeAnimation((1.0 + index) / 4,
                      itemWidget(recouvrement: recouvrementList[index]));
                }),
      ),
    );
  }

  itemWidget({required SuiviPaiement recouvrement}) {
    initializeDateFormatting();
    final f = new DateFormat('dd-MM-yyyy');
    final m = new DateFormat('MMMM yyyy', 'fr_FR');

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
                                Text(recouvrement.nomDuCotisant ?? "",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(recouvrement.periode ?? "",
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
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Statut: " + getStatus(recouvrement.statut),
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Lato"),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1),
                        child: Text(
                          "Statut de révision: ",
                          style: TextStyle(
                              color: Colors.black, fontFamily: "Lato"),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          getStatusRevision(recouvrement.statutDeRevision) ??
                              "",
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
                                "Cotisation:",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                recouvrement.cotisation ?? "",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Montant réglé:",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Lato"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                recouvrement.montantRegler ?? "",
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
                                recouvrement.numeroAppelDeCotisation ?? "",
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
                                  "Solde:",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  recouvrement.solde ?? "",
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
                                  f.format(DateTime.parse(recouvrement
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
                                  "Période:",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: "Lato"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  m.format(DateTime.parse(recouvrement.periode
                                          .toString()
                                          .substring(0, 4) +
                                      "-" +
                                      recouvrement.periode
                                          .toString()
                                          .substring(5, 7) +
                                      "-"
                                          "01")),
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

  getStatus(statut) {
    if (statut == "0") {
      return "Crée";
    } else if (statut == "1") {
      return "Déclaré";
    } else if (statut == "2") {
      return "En retard";
    } else if (statut == "3") {
      return "Redressement";
    } else if (statut == "4") {
      return "";
    } else if (statut == "5") {
      return "Clôturé";
    }
  }

  getStatusRevision(statut) {
    if (statut == "0") {
      return "Aucun";
    } else if (statut == "1") {
      return "En attente de révision";
    } else if (statut == "2") {
      return "En attente de fichier central";
    } else if (statut == "3") {
    } else if (statut == "3") {
      return "En attente du chef de section";
    } else if (statut == "4") {
      return "En attente de recouvrement";
    } else if (statut == "5") {
      return "Clôturé";
    }
  }

  _filterRecouvrementList() {
    if (isFiltered) {
      setState(() {
        recouvrementList.sort((a, b) {
          var year = a.periode.substring(0, 4);
          var month = a.periode.substring(5, 7);

          var year2 = b.periode.substring(0, 4);
          var month2 = b.periode.substring(5, 7);

          var date1 = DateTime(int.parse(year), int.parse(month), 1);
          var date2 = DateTime(int.parse(year2), int.parse(month2), 1);

          return date1.compareTo(date2);
        });
      });
    } else {
      setState(() {
        recouvrementList.sort((a, b) {
          var year = a.periode.substring(0, 4);
          var month = a.periode.substring(5, 7);

          var year2 = b.periode.substring(0, 4);
          var month2 = b.periode.substring(5, 7);

          var date1 = DateTime(int.parse(year), int.parse(month), 1);
          var date2 = DateTime(int.parse(year2), int.parse(month2), 1);

          return date2.compareTo(date1);
        });
      });
    }
  }
}
