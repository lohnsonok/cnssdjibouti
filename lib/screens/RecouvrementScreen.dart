import 'dart:convert';
import 'package:cnss_djibouti_app/models/Recouvrement.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/ApiConnexion.dart';
import '../configs/theme.dart';
import 'dashboard.dart';

class RecouvrementPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => RecouvrementPageState();
}

class RecouvrementPageState extends State<RecouvrementPage>
{
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
    }
  }

  late Future<List<Recouvrement>> futureListeRecouvrement;
  Future<List<Recouvrement>> fetchListeRecouvrement(String compteCotisant) async {
    final response = await http.get(Uri.parse(ApiConnexion.baseUrl+'/recouvrement/'+compteCotisant));

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200)
    {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Recouvrement>((json) => Recouvrement.fromMap(json)).toList();
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
          title: Text('CNSS-Djibouti'),
          centerTitle: true,
          leading: Builder(
            builder: (context) => BackButton(
              color: Colors.white, onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            },
            ),
          ),
        ),
        body: isLoading? Center(child: CircularProgressIndicator()) :
        Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(20),
                  child: Text("Recouvrement : " + assureurName,textAlign: TextAlign.center ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),
                Expanded(
                  child: FutureBuilder<List<Recouvrement>>(
                    future: futureListeRecouvrement,
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) =>
                              Container(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    color: AppTheme.randomColor(context),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("ID Dossier° : ${snapshot.data![index].id_dossier}",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Image.asset("assets/image/dues.png", width: 32, color: Colors.white,)
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text("Statut de paiement : ${snapshot.data![index].description}"),
                                      SizedBox(height: 8),

                                    ],
                                  ),
                                ),
                              ),
                        );
                      } else {
                        //return Center(child: CircularProgressIndicator());
                        return Center(child: Text("Aucun donnée trouvée"));
                      }
                    },
                  ),
                )
              ],
            )
        )
    );
  }

}