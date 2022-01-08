import 'package:cnss_djibouti_app/screens/retraite.dart';
import 'package:cnss_djibouti_app/widget/assure.dart';
import 'package:cnss_djibouti_app/widget/assurecarte.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import 'login.dart';

class homenew extends StatefulWidget {
  const homenew({Key? key}) : super(key: key);

  @override
  _homenewState createState() => _homenewState();
}

class _homenewState extends State<homenew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/cnss.jpg'),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 250, left: 20),
                //  color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Veuillez Choisir Votre Espaces',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ))),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 300,
            child: Container(
              height: 380,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 45,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Compte Cotisant",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ConfirmationSlider(
                    height: 40.0,
                    width: 300.0,
                    text: "Ouvrir",
                    backgroundColor: Colors.blue,
                    onConfirmation: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginscreen()),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Compte Assure',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ConfirmationSlider(
                    height: 40.0,
                    width: 300.0,
                    text: "Ouvrir",
                    backgroundColor: Colors.blue,
                    onConfirmation: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => assurescreen(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Simulataire des Pension',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ConfirmationSlider(
                    height: 40.0,
                    width: 300.0,
                    text: "Ouvrir",
                    backgroundColor: Colors.blue,
                    onConfirmation: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => retraitescreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
