import 'dart:convert';
import 'package:cnss_djibouti_app/animations/fade_animation.dart';
import 'package:cnss_djibouti_app/models/Recouvrement.dart';
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

class RecouvrementPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecouvrementPageState();
}

class RecouvrementPageState extends State<RecouvrementPage> {
  List<dynamic> recouvrementList = [];
  List<dynamic> recouvrements = [];
  String assureurName = "";
  String compteCotisant = "";
  bool isLoading = true;
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
      recouvrements = recouvrementList;
    }
  }

  late Future<List<Recouvrement>> futureListeRecouvrement;
  Future<List<Recouvrement>> fetchListeRecouvrement(
      String compteCotisant) async {
    final response = await http.get(
        Uri.parse(ApiConnexion.baseUrl + '/recouvrement/' + compteCotisant));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Recouvrement>((json) => Recouvrement.fromMap(json))
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
              onChanged: (val) {
                _search(val);
              },
            ),
          ),
        ),
      ),
      body: Center(child: Text("Indisponible pour le moment")),
      /* body: Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: recouvrementList.length,
                itemBuilder: (context, index) {
                  return FadeAnimation(
                    (1.0 + index) / 4,
                    itemWidget(
                      recouvrement: recouvrementList[index],
                    ),
                  );
                },
              ),
      ), */
    );
  }

  itemWidget({required Recouvrement recouvrement}) {
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
                                "ID Dossier : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(recouvrement.id_dossier ?? "",
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
                                "Statut de paiement : ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(recouvrement.description ?? "",
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
        ],
      ),
    );
  }

  _search(String value) {
    setState(() {
      if (value.isEmpty) {
        recouvrementList = recouvrements;
      } else {
        recouvrementList = recouvrements
            .where((u) =>
                (u.id_dossier ?? "")
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                (u.description ?? "")
                    .toLowerCase()
                    .contains(value.toLowerCase()))
            .toList();
      }
    });
  }
}
