import 'package:cnss_djibouti_app/screens/dashboard.dart';
import 'package:cnss_djibouti_app/screens/home.dart';
import 'package:cnss_djibouti_app/widget/resultacarte.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class assurescreen extends StatefulWidget {
  const assurescreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AssurescreenState();
}

class AssurescreenState extends State<assurescreen> {
  TextEditingController matriculeController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('CNSS-Djibouti'),
      //   centerTitle: true,
      //   leading: Builder(
      //     builder: (context) => BackButton(
      //       color: Colors.white,
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => homenew(),
      //           ),
      //         );
      //       },
      //     ),
      //   ),

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
                    image: AssetImage('assets/image/cart.jpg'),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 300, left: 20),
                //  color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
              height: 380,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 45,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: matriculeController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(35.0),
                        ),
                      ),
                      hintText: "Numero matricule",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.keyboard,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(
                          Radius.circular(35.0),
                        ),
                      ),
                      hintText: "Mot de passe",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => resulscreen(
                          urn: matriculeController.text,
                        ),
                      ),
                    ),
                    child: Text('Rechercher'),
                    fillColor: Colors.blue,
                    constraints: BoxConstraints.tightFor(
                      width: 180,
                      height: 35,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text:
                          "Pour Avoir votre Mote de Passe\ rapprochez-vous au fichier(cnss)",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}