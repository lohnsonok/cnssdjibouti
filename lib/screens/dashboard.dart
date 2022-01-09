import 'dart:ui';

import 'package:cnss_djibouti_app/screens/AppelCotisationScreen.dart';
import 'package:cnss_djibouti_app/screens/ListeAssuresScreen.dart';
import 'package:cnss_djibouti_app/screens/RecouvrementScreen.dart';
import 'package:cnss_djibouti_app/screens/SuiviPaiementScreen.dart';
import 'package:cnss_djibouti_app/widget/appdrawer.dart';
import 'package:cnss_djibouti_app/widget/assure.dart';
import 'package:cnss_djibouti_app/widget/categoryCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum RequestState { Ongoing, Success, Error, Starting }

class _MyHomePageState extends State<Dashboard> {
  String assureurName = "";
  late SharedPreferences preferences;
  _loadUser() async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getString('nom') != null) {
      setState(() {
        assureurName = preferences.getString('nom')!;
      });
    }
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
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF908AFB),
              image: DecorationImage(
                alignment: Alignment.bottomLeft,
                image: AssetImage("assets/images/shape.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
/*                   Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ), */
                  SizedBox(
                    height: 50,
                  ),
                  Text("Bonjour \nAmed Ali",
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
