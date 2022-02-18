import 'dart:convert';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:cnss_djibouti_app/configs/ApiConnexion.dart';
import 'package:cnss_djibouti_app/screens/dashboard.dart';
import 'package:cnss_djibouti_app/screens/retraite.dart';
import 'package:cnss_djibouti_app/widget/delayed_animation.dart';
import 'package:community_material_icon/community_material_icon.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

const double _fabDimension = 56.0;

class _loginState extends State<login> {
  bool isMale = true;
  bool isRemebre = false;
  bool loading = false;
  bool isAssuree = false;

  late SharedPreferences preferences;

  TextEditingController compteCotisantController = new TextEditingController()
    ..text = '0600000000001';
  TextEditingController passwordController = new TextEditingController()
    ..text = 'cnss2021';

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 10,
                right: -10,
                child: Container(
                  width: 300,
                  height: 300,
                  child: Image.asset(
                    'assets/images/energy.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 80,
                    sigmaY: 80,
                  ),
                  child: Container(),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      _logo(),
                      const SizedBox(
                        height: 70,
                      ),
                      _loginLabel(),
                      const SizedBox(
                        height: 70,
                      ),
                      builldtextfield("Numéro", "numero cotisant ou assure ",
                          false, compteCotisantController),
                      const SizedBox(
                        height: 50,
                      ),
                      builldtextfield("Mot de passe", "votre mot de passe",
                          true, passwordController),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Pour obtenir votre mot de passe, veuillez vous rapprochez du Service Recouvrements(CNSS)",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      _loginBtn(),
                      const SizedBox(
                        height: 70,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OpenContainer<bool>(
                          transitionType: _transitionType,
                          openBuilder:
                              (BuildContext _, VoidCallback openContainer) {
                            return const RetraiteScreen();
                          },
                          tappable: false,
                          closedColor: Colors.transparent,
                          closedShape: const RoundedRectangleBorder(),
                          closedElevation: 0.0,
                          closedBuilder:
                              (BuildContext _, VoidCallback openContainer) {
                            return _signUpLabel(
                                "Simuler ma Pension de Retraite",
                                const Color(0xff164276),
                                openContainer);
                          }),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpLabel(
      String label, Color textColor, VoidCallback openContainer) {
    return GestureDetector(
        onTap: openContainer,
        child: Text(
          label,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
              fontSize: 18,
              fontFamily: "Lato"),
        ));
  }

  Widget _loginBtn() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff00a7e5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
          onPressed: () => {
                setState(() {
                  loading = true;
                }),
                _login(),
              },
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: new AlwaysStoppedAnimation(Color(0xFFFFFFFF)),
                )
              : Text(
                  "Connexion",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                      fontFamily: "Lato"),
                )),
    );
  }

  Widget builldtextfield(String label, String hintText, bool isPassword,
      TextEditingController controller) {
    return DelayedAnimation(
        delay: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Color(0xff8fa1b6),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: "Lato"),
            ),
            TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Color(0xffc5d2e1),
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    fontFamily: "Lato"),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffdfe8f3)),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _loginLabel() {
    return DelayedAnimation(
        delay: 50,
        child: Center(
          child: Text(
            "Bienvenue à CNSS",
            style: const TextStyle(
                color: Color(0xff333c8b),
                fontWeight: FontWeight.w900,
                fontSize: 34,
                fontFamily: "Lato"),
          ),
        ));
  }

  Widget _logo() {
    return DelayedAnimation(
      delay: 10,
      child: Center(
        child: SizedBox(
          child: Image.asset(
            "assets/images/logo.jpg",
          ),
          height: 100,
        ),
      ),
    );
  }

  void _login() async {
    //if(_formKey.currentState.validate())
    preferences = await SharedPreferences.getInstance();
    Dio dio = Dio(ApiConnexion().baseOptions());

    String numero = compteCotisantController.text;
    String password = passwordController.text;
    var response = await dio.post('/login_cotisant',
        data: {'compte_cotisant': numero, 'mot_passe': password});
    //widget.onChangedStep(1)
    if (response.data["Compte_Cotisant"] == null) {
      response = await dio
          .post('/login_assure', data: {'urn': numero, 'mot_passe': password});
      if (response.data["URN"] != null) {
        setState(() {
          isAssuree = true;
        });
      }
    }
    setState(() {
      loading = false;
    });
    if ((response.data["Compte_Cotisant"] == null && !isAssuree) ||
        (response.data["URN"] == null && isAssuree)) {
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
      if (response.data["Compte_Cotisant"] != null)
        await preferences.setString("compte_cotisant", numero);
      if (response.data["Compte_Cotisant"] != null)
        await preferences.setString("nom", response.data["Nom"]);
      if (response.data["URN"] != null)
        await preferences.setString(
            "nom", response.data["FName"] + ' ' + response.data["OName"]);
      if (response.data["URN"] != null)
        await preferences.setString("compte_assuree", numero);
      await preferences.setBool("isAssuree", isAssuree);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    }
  }
}
