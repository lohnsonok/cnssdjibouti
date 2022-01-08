import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

import '../widget/assure.dart';
import 'login.dart';
import 'retraite.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/image/cnss.jpg'),
            maxRadius: 100,
            minRadius: 100,
          ),
          Text(
            "Veuillez choisir votre Espace",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            'Compte Cotisant ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ConfirmationSlider(
            height: 40.0,
            width: 300.0,
            text: "Ouvrir",
            backgroundColor: Color(0XFFfcb103),
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
              'Compte Assures',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ConfirmationSlider(
            height: 40.0,
            width: 300.0,
            text: "Ouvrir",
            backgroundColor: Color(0XFFfcb103),
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ConfirmationSlider(
            height: 40.0,
            width: 300.0,
            text: "Ouvrir",
            backgroundColor: Color(0XFFfcb103),
            onConfirmation: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => retraitescreen(),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
