import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:cnss_djibouti_app/animations/fade_animation.dart';
import 'package:cnss_djibouti_app/models/Communique.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';
import 'dashboard.dart';

const double _fabDimension = 56.0;

class CommuniquesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommuniquesPageState();
}

class CommuniquesPageState extends State<CommuniquesPage> {
  List<dynamic> communiqueList = [];

  bool isLoading = true;

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

    futureListeCommunique = fetchListeCommunique();
    communiqueList = await futureListeCommunique;
  }

  late Future<List<Communique>> futureListeCommunique;
  Future<List<Communique>> fetchListeCommunique() async {
    final response =
        await http.get(Uri.parse(ApiConnexion.baseUrl + '/communiques'));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

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
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Communiqués",
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
                itemCount: communiqueList.length,
                itemBuilder: (context, index) {
                  return FadeAnimation((1.0 + index) / 4,
                      itemWidget(communique: communiqueList[index]));
                }),
      ),
    );
  }

  itemWidget({required Communique communique}) {
    initializeDateFormatting();
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
                              Text(communique.title ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(communique.body ?? "",
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
                        "Date: " +
                            f.format(DateTime.parse(communique.created_at
                                .toString()
                                .substring(0, 10))),
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Lato"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
