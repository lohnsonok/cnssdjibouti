import 'package:cnss_djibouti_app/configs/ApiConnexion.dart';
import 'package:cnss_djibouti_app/screens/dashboard.dart';
import 'package:community_material_icon/community_material_icon.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}

// ignore: camel_case_types
class _loginscreenState extends State<loginscreen> {
  bool isMale = true;
  // bool isSignup = true;
  bool isRemebre = false;
  bool loading = false;
  late SharedPreferences preferences;

  TextEditingController compteCotisantController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                    image: AssetImage('assets/image/login.jpg'),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Bienvenue CNSS",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.yellow[700],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Page Connexion",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 380,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 45,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Connexion".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        builldtextfield(
                            CommunityMaterialIcons.account_outline,
                            "Numero Cotisants",
                            false,
                            false,
                            compteCotisantController),
                        SizedBox(
                          height: 10,
                        ),
                        builldtextfield(CommunityMaterialIcons.onepassword,
                            "Mot de passe", true, false, passwordController),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          "Pour Avoir votre Mote de Passe Veuillez vous rapprochez au Service Recouvrements(CNSS)",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 535,
            right: 0,
            left: 0,
            child: InkWell(
              onTap: () {},
              child: Center(
                child: Container(
                  height: 90,
                  width: 90,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: loading
                      ? CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor:
                              new AlwaysStoppedAnimation(Color(0xFF6aa6f8)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.green, Colors.greenAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.3),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1))
                              ]),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                loading = true;
                              });
                              _login();
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget builldtextfield(IconData icon, String hinText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.blue,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0Xfff0f2e9),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          hintText: hinText,
        ),
      ),
    );
  }

  void _login() async {
    //if(_formKey.currentState.validate())
    preferences = await SharedPreferences.getInstance();
    Dio dio = Dio(ApiConnexion().baseOptions());

    String name = compteCotisantController.text;
    String password = passwordController.text;
    var response = await dio.post('/login_cotisant',
        data: {'compte_cotisant': name, 'mot_passe': password});
    //widget.onChangedStep(1)
    setState(() {
      loading = false;
    });
    if (response.data["compte_cotisant"] == null) {
      AlertDialog dialog = AlertDialog(
        title: const Text('Info Connexion'),
        content: const Text('Oops ! Aucun compte trouvé !'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        },
      );
    } else {
      await preferences.setString(
          "compte_cotisant", response.data["compte_cotisant"]);
      await preferences.setString("nom", response.data["nom"]);
      /*await preferences.setString("secteur_d_activite", response.data["secteur_d_activite"]);
        await preferences.setString("sous_secteur_d_activite", response.data["sous_secteur_d_activite"]);
        await preferences.setString("type_d_affiliation", response.data["type_d_affiliation"]);
        await preferences.setString("statut", response.data["statut"]);
        await preferences.setString("date_d_affiliation", response.data["date_d_affiliation"]);
        await preferences.setString("type_de_cotisant", response.data["type_de_cotisant"]);
        await preferences.setString("date_de_radiation", response.data["date_de_radiation"]);
        await preferences.setString("date_de_suspension", response.data["date_de_suspension"]);
        await preferences.setString("date_de_creation_de_l_entreprise", response.data["date_de_creation_de_l_entreprise"]);
        await preferences.setString("telephone", response.data["telephone"]);*/

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    }
  }
}
