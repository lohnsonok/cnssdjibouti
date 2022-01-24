import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:cnss_djibouti_app/animations/fade_animation.dart';
import 'package:cnss_djibouti_app/models/CotisantAssure.dart';
import 'package:cnss_djibouti_app/screens/retraite.dart';
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

class ListeAssuresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListeAssuresPageState();
}

const double _fabDimension = 56.0;

class ListeAssuresPageState extends State<ListeAssuresPage> {
  List<dynamic> assuresList = [];
  List<dynamic> assures = [];
  String assureurName = "";
  String compteCotisant = "";
  bool isLoading = true;

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController minDateController = TextEditingController();
  TextEditingController maxDateController = TextEditingController();

  late SharedPreferences preferences;

  List<bool> purchaseType = [false, false, false];
  String propertyType = 'Apartment & Unit';

  _loadUser() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getString('nom') != null) {
      setState(() {
        assureurName = preferences.getString('nom')!;
        compteCotisant = preferences.getString('compte_cotisant')!;
      });

      futureListeAssures = fetchListeAssures(compteCotisant);
      assures = await futureListeAssures;
      assuresList = assures;
    }
  }

  TextEditingController searchController = new TextEditingController();

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
      throw Exception('Failed to load data');
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
              child: OpenContainer(
                transitionType: _transitionType,
                openBuilder: (BuildContext context, VoidCallback _) {
                  return filterOverlayWidget();
                },
                closedElevation: 0.0,
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(_fabDimension / 2),
                  ),
                ),
                closedColor: Colors.transparent,
                closedBuilder:
                    (BuildContext context, VoidCallback openContainer) {
                  return GestureDetector(
                      onTap: openContainer,
                      child: SizedBox(
                          height: _fabDimension,
                          width: _fabDimension,
                          child: Center(
                              child: Icon(
                            Icons.filter_list,
                            color: Colors.grey.shade400,
                          ))));
                },
              ),
            )
          ],
          title: Container(
            height: 45,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: searchController,
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
                onChanged: (val) {
                  _search(val);
                },
              ),
            ),
          ),
        ),
        body: Container(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : assuresList.length == 0
                  ? Center(
                      child: Text("Aucun donnée trouvée pour ce compte : " +
                          compteCotisant))
                  : ListView.builder(
                      padding: EdgeInsets.all(20),
                      itemCount: assuresList.length,
                      itemBuilder: (context, index) {
                        return FadeAnimation((1.0 + index) / 4,
                            itemWidget(assure: assuresList[index]));
                      }),
        ));
  }

  itemWidget({required CotisantAssure assure}) {
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
      child: Column(
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Numéro Assuré : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(assure.compte_assure ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nom Assuré : ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(assure.nomAssure ?? "",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Lato",
                                          fontWeight: FontWeight.w700))),
                            ],
                          ),
                        ]),
                  )
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Salaire brut : ",
                    style: TextStyle(
                        fontFamily: "Lato", fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(assure.salaire ?? "",
                      style: TextStyle(
                          color: Colors.grey[500], fontFamily: "Lato")),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date d'embauche : ",
                    style: TextStyle(
                        fontFamily: "Lato", fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      f.format(DateTime.parse(
                          assure.date_d_embauche.toString().substring(0, 10))),
                      style: TextStyle(
                          color: Colors.grey[500], fontFamily: "Lato")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _search(String value) {
    setState(() {
      if (value.isEmpty) {
        assuresList = assures;
      } else {
        assuresList = assures
            .where((u) =>
                (u.nomAssure ?? "")
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                (u.compte_assure ?? "")
                    .toLowerCase()
                    .contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  filterOverlayWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Filtrer par : ",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Lato",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2 - 50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    child: const Text('Salaire Min'),
                                  ),
                                  Container(
                                    height: 40,
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: minController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    child: const Text('Salaire Max'),
                                  ),
                                  Container(
                                    height: 40,
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: maxController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "Date d'embauche : ",
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    child: const Text('De'),
                                  ),
                                  Container(
                                      height: 40,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        controller: minDateController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Lato",
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 16, 16, 0),
                                    child: const Text('AU'),
                                  ),
                                  Container(
                                    height: 40,
                                    alignment: AlignmentDirectional.centerStart,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      controller: maxDateController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Lato",
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => {},
                                child: Text(
                                  "Appliquez",
                                  style: TextStyle(fontFamily: "Lato"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
