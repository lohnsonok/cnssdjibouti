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
  // bool isSignup = true;
  bool isRemebre = false;
  bool loading = false;
  late SharedPreferences preferences;

  TextEditingController compteCotisantController = new TextEditingController()
    ..text = '0600000000001';
  TextEditingController passwordController = new TextEditingController()
    ..text = 'cnss2020';

  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false)
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
  }

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
                            return const RetraiteScreen(
                                includeMarkAsDoneButton: true);
                          },
                          onClosed: _showMarkedAsDoneSnackbar,
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

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
    }
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback? openContainer;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
