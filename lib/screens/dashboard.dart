import 'dart:convert';
import 'dart:ui';
import 'package:cnss_djibouti_app/animations/fade_animation.dart';
import 'package:cnss_djibouti_app/configs/ApiConnexion.dart';
import 'package:cnss_djibouti_app/models/TxnDependent.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:cnss_djibouti_app/screens/AppelCotisationScreen.dart';
import 'package:cnss_djibouti_app/screens/ListeAssuresScreen.dart';
import 'package:cnss_djibouti_app/screens/RecouvrementScreen.dart';
import 'package:cnss_djibouti_app/screens/SuiviPaiementScreen.dart';
import 'package:cnss_djibouti_app/widget/appdrawer.dart';
import 'package:cnss_djibouti_app/widget/categoryCard.dart';
import 'package:cnss_djibouti_app/widget/navigation_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum RequestState { Ongoing, Success, Error, Starting }

class _MyHomePageState extends State<Dashboard> {
  List<dynamic> assuresList = [];
  List<dynamic> assures = [];
  bool isLoading = true;

  String assureurName = "";
  bool isAssuree = false;
  String compteCotisant = "";
  late SharedPreferences preferences;
  TextEditingController searchController = new TextEditingController();
  late Future<List<TxnDependent>> futureListeAssures;

  _loadUser() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getString('nom') != null) {
      setState(() {
        assureurName = preferences.getString('nom')!;
      });
    }

    setState(() {
      isAssuree = preferences.getBool('isAssuree')!;

      if (!isAssuree) {
        compteCotisant = preferences.getString('compte_cotisant')!;
      } else {
        compteCotisant = preferences.getString('compte_assuree')!;
      }
    });

    futureListeAssures = fetchListeAssures(compteCotisant);
    assures = await futureListeAssures;
    assuresList = assures;
  }

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
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Widget cardContent(String imageName, String text, {required Widget page}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Image.asset(
                imageName,
                width: 64,
              ),
              height: 70,
              width: 70,
            )),
        Text(
          text.toUpperCase(),
          style: TextStyle(
              //color: kPrimaryColor,
              fontSize: 12),
        )
      ],
    );
  }

  boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(2, 5),
          blurRadius: 1,
          color: Colors.grey.withOpacity(.6),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      extendBodyBehindAppBar: true,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 20,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          // leading none
          automaticallyImplyLeading: false,
          actions: [
            Builder(
              builder: (context) => Align(
                alignment: Alignment.topRight,
                child: Container(
                  alignment: Alignment.center,
                  height: 52,
                  width: 52,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ),
            )
          ]),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF0075a0),
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage("assets/images/shape.png"),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _getWelcome(),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _getMedicalAccessStatus(),
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(child: _getContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getWelcome() {
    return Text(assureurName,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w700));
  }

  _getMedicalAccessStatus() {
    if (isAssuree) {
      return Container(
        child: Text(
          "Vous avez accès au soins",
          style: TextStyle(
              fontFamily: "Lato",
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      );
    }
  }

  _getCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: .85,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: <Widget>[
          CategoryCard(
            title: "Liste des Employés",
            src: "assets/icons/employees.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ListeAssuresPage();
                }),
              );
            },
          ),
          CategoryCard(
            title: "Appel de cotisation",
            src: "assets/icons/savings.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AppelCotisationPage();
                }),
              );
            },
          ),
          CategoryCard(
            title: "Suivi Paiements",
            src: "assets/icons/receipt.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SuiviPaiementPage();
                }),
              );
            },
          ),
          CategoryCard(
            title: "Recouvrement",
            src: "assets/icons/collecting.png",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return RecouvrementPage();
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  _buildListeAssuree() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: searchController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
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
            SizedBox(
              height: 25,
            ),
            Container(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : assuresList.length == 0
                      ? Center(
                          child: Text("Aucun donnée trouvée pour ce compte : " +
                              compteCotisant))
                      : Expanded(
                          child: SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                itemCount: assuresList.length,
                                itemBuilder: (context, index) {
                                  return FadeAnimation((1.0 + index) / 4,
                                      itemWidget(assure: assuresList[index]));
                                }),
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }

  _getContent() {
    if (!isAssuree) {
      return _getCards();
    } else {
      return _buildListeAssuree();
    }
  }

  itemWidget({required TxnDependent assure}) {
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
                                "Nom Assuré : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(assure.MemberName,
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
                                "Id membre : ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Lato",
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(assure.MemberID,
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
                    "Sexe : ",
                    style: TextStyle(
                        fontFamily: "Lato", fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(assure.Gender,
                      style: TextStyle(
                          color: Colors.grey[500], fontFamily: "Lato")),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date de naissance : ",
                    style: TextStyle(
                        fontFamily: "Lato", fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                      f.format(DateTime.parse(
                          assure.Dob.toString().substring(0, 10))),
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
            .where((u) => (u.MemberName ?? "")
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      }
    });
  }
}
