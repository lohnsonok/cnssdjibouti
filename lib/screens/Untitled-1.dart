import 'package:cnss_djibouti_app/widget/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class RetraiteScreen extends StatefulWidget {
  final bool includeMarkAsDoneButton;

  const RetraiteScreen({
    Key? key,
    required this.includeMarkAsDoneButton,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => RetraiteScreenState();
}

class RetraiteScreenState extends State<RetraiteScreen> {
  String _chosenValue = "RG";
  bool afficher_label_indice_solde = true;
  bool afficher_et_indice_solde = true;

  bool isRG = true;
  bool isFCT = false;
  bool isDMG = false;
  bool isFNP = false;

  int nbreAnnee1 = 0;
  int nbreAnnee2 = 0;
  int nbreAnnee3 = 0;

  TextEditingController ddnCtrl = new TextEditingController();
  TextEditingController nbreAnneeCtrl = new TextEditingController();
  TextEditingController nbreAnneeCtrl2 = new TextEditingController();
  TextEditingController nbreAnneeCtrl3 = new TextEditingController();
  TextEditingController salaireCtrl = new TextEditingController();
  TextEditingController indiceCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Simulateur Pension retraite'),
          actions: <Widget>[
            if (widget.includeMarkAsDoneButton)
              IconButton(
                icon: const Icon(Icons.done),
                onPressed: () => Navigator.pop(context, true),
                tooltip: 'Mark as done',
              )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Simulateur Pension Normal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                    'Quelle est votre date de Naissance? (veuillez respecter les format jour/mois/année)'),
                SizedBox(height: 5),
                TextField(
                  controller: ddnCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'jj/mm/aaaa'),
                ),
                SizedBox(height: 10),
                Text(
                  'A quel régime cotisez-vous ?',
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(1, 1),
                        //blurRadius: 1,
                        color: Colors.grey.withOpacity(.6),
                      )
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),
                    items: <String>[
                      'RG',
                      'FCT',
                      'FNP',
                      'DMG',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _chosenValue = value!;
                      });

                      switch (value) {
                        case "RG":
                          setState(() {
                            afficher_label_indice_solde = false;
                            afficher_et_indice_solde = false;
                          });
                          break;

                        case "FCT":
                          setState(() {
                            afficher_label_indice_solde = true;
                            afficher_et_indice_solde = true;
                          });
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                    "Pendant combien d'années avez-vous travaillé entre 1976 et 2001"),
                SizedBox(height: 5),
                TextField(
                  controller: nbreAnneeCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: ''),
                ),
                SizedBox(height: 10),
                Text(
                    "Pendant combien d'années avez-vous travaillé entre 2002 et 2007"),
                SizedBox(height: 5),
                TextField(
                  controller: nbreAnneeCtrl2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: ''),
                ),
                SizedBox(height: 10),
                Text(
                    "Pendant combien d'années avez-vous travaillé de 2008 à aujourd'hui"),
                SizedBox(height: 05),
                TextField(
                  controller: nbreAnneeCtrl3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: ''),
                ),
                SizedBox(height: 10),
                Text(
                    "Indiquez la moyenne de votre salaire brut mensuel des 10 dernères années"),
                SizedBox(height: 5),
                TextField(
                  controller: salaireCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: ''),
                ),
                afficher_label_indice_solde
                    ? Text('Indice du solde')
                    : Text(""),
                afficher_et_indice_solde
                    ? TextField(
                        controller: indiceCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            hintText: ''),
                      )
                    : Text(""),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      int nbreAnnee1 = nbreAnneeCtrl.text.isEmpty
                          ? 0
                          : int.parse(nbreAnneeCtrl.text);
                      int nbreAnnee2 = nbreAnneeCtrl2.text.isEmpty
                          ? 0
                          : int.parse(nbreAnneeCtrl2.text);
                      int nbreAnnee3 = nbreAnneeCtrl3.text.isEmpty
                          ? 0
                          : int.parse(nbreAnneeCtrl3.text);

                      double salaireBrut = salaireCtrl.text.isEmpty
                          ? 0.0
                          : double.parse(salaireCtrl.text);

                      int dureeCotisation =
                          nbreAnnee1 + nbreAnnee2 + nbreAnnee3;

                      var dateNaissanceSplit = ddnCtrl.text.split('/');
                      if (dateNaissanceSplit.length < 3)
                        MAlertDialog.show(
                            "Format de la date incorrect", context);
                      else {
                        int annee = int.parse(dateNaissanceSplit[2]);
                        var currentAnnee = new DateTime.now().year;
                        int age = currentAnnee - annee;

                        if (_chosenValue == "RG") {
                          MAlertDialog.show(
                              regimeRG(age, dureeCotisation, nbreAnnee1,
                                      nbreAnnee2, nbreAnnee3, salaireBrut)
                                  .toString(),
                              context);
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      child: Center(
                        child: Text("SIMULER"),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

  double regimeFCT(int age, int dureeCotisation) {
    var pensionNet = 0.0;
    if (age < 60) {
      MAlertDialog.show("Vous devez avoir au moins 60ans", context);
    } else if (dureeCotisation < 25) {
      MAlertDialog.show("Vous devez cotiser pour au moins 25ans", context);
    }
    return pensionNet;
  }

  double regimeRG(int age, int dureeCotisation, int nbreAnnee1, int nbreAnnee2,
      int nbreAnnee3, double salaireBrut) {
    var pensionNet = 0.0;
    if (age < 60) {
      MAlertDialog.show("Vous devez avoir au moins 60ans", context);
    } else if (dureeCotisation < 25) {
      MAlertDialog.show("Vous devez cotiser pour au moins 25ans", context);
    } else {
      double tc1 = 0.02 * nbreAnnee1;
      double tc2 = 0.018 * nbreAnnee2;
      double tc3 = 0.015 * nbreAnnee3;
      double tcc = tc1 + tc2 + tc3;

      double pensionBrute = salaireBrut * tcc;
      pensionNet = (pensionBrute > 50000)
          ? pensionBrute - (pensionBrute * 0.03)
          : pensionBrute;
    }
    return pensionNet;
  }
}
