import 'package:cnss_djibouti_app/screens/AppelCotisationScreen.dart';
import 'package:cnss_djibouti_app/screens/ListeAssuresScreen.dart';
import 'package:cnss_djibouti_app/screens/RecouvrementScreen.dart';
import 'package:cnss_djibouti_app/screens/SuiviPaiementScreen.dart';
import 'package:cnss_djibouti_app/widget/appdrawer.dart';
import 'package:cnss_djibouti_app/widget/assure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum RequestState {
  Ongoing,
  Success,
  Error,
  Starting
}

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

  Widget cardContent(String imageName, String text, { required Widget page }){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => page,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Image.asset(imageName, width: 64,),
              height: 70,
              width: 70,
            )
        ),
        Text(text.toUpperCase(),
          style: TextStyle(
            //color: kPrimaryColor,
              fontSize: 12
          ),
        )
      ],
    );
  }

  boxDecoration()
  {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('CNSS-Djibouti'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20),
                child: Text(assureurName,textAlign: TextAlign.center ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),

              Expanded(
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ListeAssuresPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Image.asset("assets/image/employees.png", width: 64,),
                                      height: 70,
                                      width: 70,
                                    )
                                ),
                                Text("Liste des employés",
                                  style: TextStyle(
                                    //color: kPrimaryColor,
                                      fontSize: 12
                                  ),
                                )
                              ],
                            ),
                            //color: Colors.red[200],
                            decoration: boxDecoration(),
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecoration(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AppelCotisationPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: Image.asset("assets/image/dues.png", width: 64,),
                                        height: 70,
                                        width: 70,
                                      )
                                  ),
                                  Text("Appel de cotisation",
                                    style: TextStyle(
                                      //color: kPrimaryColor,
                                        fontSize: 12
                                    ),
                                  )
                                ],
                              )
                          ),

                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Center(child: cardContent("assets/image/payment.png", "Recouvrement", page: RecouvrementPage()),),
                            decoration: boxDecoration(),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Center(child: cardContent("assets/image/folder.png", "Suivi Payement", page: SuiviPaiementPage()),),
                            decoration: boxDecoration(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )

      ),
      drawer: AppDrawer(),
    );
  }
}

