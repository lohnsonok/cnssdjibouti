import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cnss_djibouti_app/widget/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class RetraiteScreen extends StatefulWidget {
  const RetraiteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => RetraiteScreenState();
}

class RetraiteScreenState extends State<RetraiteScreen>
    with TickerProviderStateMixin {
  late AnimationController _animateController;
  late AnimationController _longPressController;
  late AnimationController _secondStepController;
  late AnimationController _thirdStepController;
  late AnimationController _fourStepController;
  late AnimationController _fiveStepController;
  late AnimationController _sixStepController;
  late AnimationController _sevenStepController;
  late AnimationController _eightStepController;
  late AnimationController _nineStepController;
  late AnimationController _tenStepController;
  late AnimationController _finalStepController;

  int curIndex = 0;
  bool isDisabled = true;
  bool isLoadingCalculated = false;
  late String regime = "";
  late String extimatedTo = "";

  TextEditingController birthdateCtrl = new TextEditingController();
  TextEditingController year1976_2001Ctrl = new TextEditingController();
  TextEditingController year2002_todayCtrl = new TextEditingController();
  TextEditingController year2002_2006Ctrl = new TextEditingController();
  TextEditingController year2007_2009Ctrl = new TextEditingController();
  TextEditingController year2007_todayCtrl = new TextEditingController();
  TextEditingController year2010_todayCtrl = new TextEditingController();
  TextEditingController salaireCtrl = new TextEditingController();
  TextEditingController indiceCtrl = new TextEditingController();

  late Animation<double> longPressAnimation;
  late Animation<double> secondTranformAnimation;
  late Animation<double> thirdTranformAnimation;
  late Animation<double> fourTranformAnimation;
  late Animation<double> fiveTranformAnimation;
  late Animation<double> sixTranformAnimation;
  late Animation<double> sevenTranformAnimation;
  late Animation<double> eightTranformAnimation;
  late Animation<double> nineTranformAnimation;
  late Animation<double> tenTranformAnimation;
  late Animation<double> finalTranformAnimation;

  Logger _logger = Logger();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fiveStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _sixStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _sevenStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _eightStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _nineStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _tenStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _finalStepController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fourTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fourStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fiveTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fiveStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    sixTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _sixStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    sevenTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _sevenStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    eightTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _eightStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    nineTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _nineStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    tenTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _tenStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    finalTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _finalStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });

    _fiveStepController.addListener(() {
      setState(() {});
    });

    _sixStepController.addListener(() {
      setState(() {});
    });

    _sevenStepController.addListener(() {
      setState(() {});
    });

    _eightStepController.addListener(() {
      setState(() {});
    });

    _nineStepController.addListener(() {
      setState(() {});
    });

    _tenStepController.addListener(() {
      setState(() {});
    });

    _finalStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
    _fourStepController.dispose();
    _fiveStepController.dispose();
    _sixStepController.dispose();
    _sevenStepController.dispose();
    _eightStepController.dispose();
    _nineStepController.dispose();
    _tenStepController.dispose();
    _finalStepController.dispose();
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startLongPressAnimation() async {
    try {
      await _longPressController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFourStepAnimation() async {
    try {
      await _fourStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFiveStepAnimation() async {
    try {
      await _fiveStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSixStepAnimation() async {
    try {
      await _sixStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSevenStepAnimation() async {
    try {
      await _sevenStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startEightStepAnimation() async {
    try {
      await _eightStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startNineStepAnimation() async {
    try {
      await _nineStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startTenStepAnimation() async {
    try {
      await _tenStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startFinalStepAnimation() async {
    try {
      await _finalStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted && curIndex != 10
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (!isDisabled) {
                      if (regime == "DMG" && curIndex == 2) {
                        curIndex = 6;
                      } else if (regime == "DMG" && curIndex == 6) {
                        curIndex = 9;
                      } else if (regime == "RG" && curIndex == 5 ||
                          regime == "DMG" && curIndex == 9 ||
                          ((regime == "FCT" || regime == "FNP") &&
                              curIndex == 9)) {
                        curIndex = 10;
                        isLoadingCalculated = true;
                        Timer timer = new Timer(new Duration(seconds: 1), () {
                          calculateSolde();
                        });
                      } else if ((regime == "FCT" || regime == "FNP") &&
                          curIndex == 3) {
                        curIndex = 7;
                      } else {
                        curIndex += 1;
                      }
                    }
                    if (curIndex == 1 && !isDisabled) {
                      _startSecondStepAnimation();
                    } else if (curIndex == 2 && !isDisabled && regime != "") {
                      _startThirdStepAnimation();
                    } else if (curIndex == 3 && !isDisabled) {
                      _startFourStepAnimation();
                    } else if (curIndex == 4 && !isDisabled) {
                      _startFiveStepAnimation();
                    } else if (curIndex == 5 && !isDisabled) {
                      _startSixStepAnimation();
                    } else if (curIndex == 6 && !isDisabled) {
                      _startSevenStepAnimation();
                    } else if (curIndex == 7 && !isDisabled) {
                      _startEightStepAnimation();
                    } else if (curIndex == 8 && !isDisabled) {
                      _startNineStepAnimation();
                    } else if (curIndex == 9 && !isDisabled) {
                      _startTenStepAnimation();
                    } else if (curIndex == 10 && !isDisabled) {
                      _finalStepController.forward();
                    }
                    isDisabled = true;
                  });
                },
                child: Center(
                    child: Text(
                  curIndex != 5 && curIndex != 9 ? 'Suivant' : 'Simuler',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: isDisabled ? Colors.grey : Color(0xff333c8b)),
                )),
              ),
            ))
          : null,
    );
  }

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
//                color: Colors.blue,
          margin: EdgeInsets.only(top: 30.0),
          height: 20.0,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
//                    color: Color(0xff333c8b),
                    color: Color(0xff333c8b),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  height: 10.0,
                  width: (_width - 32.0 - 15.0) / 4.0,
                  margin: EdgeInsets.only(left: 5.0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    ("Annuler"),
                    style: TextStyle(color: Color(0xff333c8b), fontSize: 15.0),
                  ),
                )
              ]),
        ),
        _getStep()
      ],
    );
  }

  _getStep() {
    switch (curIndex) {
      case 0:
        return _getFirstStep();
      case 1:
        return _getSecondStep();
      case 2:
        return _getThirdStep();
      case 3:
        return _getFourStep();
      case 4:
        return _getFiveStep();
      case 5:
        return _getSixStep();
      case 6:
        return _getSevenStep();
      case 7:
        return _getEightStep();
      case 8:
        return _getNineStep();
      case 9:
        return _getTenStep();
      case 10:
        return _getFinalStep();
      default:
        return Container();
    }
  }

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                "Quelle est votre date de Naissance ?",
                style: TextStyle(
                    color: Color(0xff333c8b),
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  height: 80.0,
                  child: Card(
                    child: Column(children: [
                      TextField(
                        controller: birthdateCtrl,
                        onChanged: (value) {
                          if (value != "" && value.length == 10) {
                            if (value.substring(2, 3) == "/" &&
                                value.substring(5, 6) == "/") {
                              isDisabled = false;
                            } else {
                              isDisabled = true;
                            }
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'JJ/MM/AAAA',
                          hintStyle: TextStyle(
                              color: Color(0xff333c8b), fontSize: 20.0),
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                        style:
                            TextStyle(color: Color(0xff333c8b), fontSize: 20.0),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SecondQuestion> secondQuestionList = [
    SecondQuestion('RG', false),
    SecondQuestion('FCT', false),
    SecondQuestion('FNP', false),
    SecondQuestion('DMG', false),
  ];
  Widget _getSecondStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - secondTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: secondTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    "A quel régime cotisez-vous ?",
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Card(
                        child: Column(
                          children: List.generate(secondQuestionList.length,
                              (int index) {
                            SecondQuestion question = secondQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      secondQuestionList.forEach((element) {
                                        element.isSelected = false;
                                      });
                                      question.isSelected =
                                          !question.isSelected;
                                      regime = question.displayContent;
                                      regime != ""
                                          ? isDisabled = false
                                          : isDisabled = true;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    height: 50.0,
                                    color: question.isSelected
                                        ? Color(0xff333c8b).withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(question.displayContent),
                                        IconButton(
                                            icon: Icon(Icons.check),
                                            color: question.isSelected
                                                ? Color(0xff333c8b)
                                                : Colors.white,
                                            onPressed: () => {})
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < secondQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getThirdStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    "Pendant combien d\'années avez-vous travaillé entre 1976 et 2001 ?",
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: year1976_2001Ctrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFourStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fourTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: fourTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    "Pendant combien d\'années avez-vous travaillé entre 2002 et 2006 ?",
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: year2002_2006Ctrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFiveStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - fiveTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: fiveTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    "Pendant combien d\'années avez-vous travaillé de 2007 à aujourd\'hui ?",
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: year2007_todayCtrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSixStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - sixTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: sixTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Indiquez la moyenne de votre salaire brut mensuel des 10 dernères années',
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: salaireCtrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSevenStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - sevenTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: sevenTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Pendant combien d\'années avez-vous travaillé de 2002 à aujourd\'hui ?',
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: year2002_todayCtrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getEightStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - eightTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: eightTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Pendant combien d\'années avez-vous travaillé entre 2007 et 2009 ?',
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: year2007_2009Ctrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getNineStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - nineTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: nineTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Pendant combien d\'années avez-vous travaillé de 2010 à aujourd\'hui ?',
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: year2010_todayCtrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTenStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - tenTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: tenTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'Indiquer l\'Indice du solde des 2 dernières années',
                    style: TextStyle(
                        color: Color(0xff333c8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 80.0,
                      child: Card(
                        child: Column(children: [
                          TextField(
                            controller: indiceCtrl,
                            onChanged: (value) {
                              value != ""
                                  ? isDisabled = false
                                  : isDisabled = true;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            decoration: InputDecoration(
                              hintText: 'Entrez votre réponse',
                              hintStyle: TextStyle(
                                  color: Color(0xff333c8b), fontSize: 20.0),
                              contentPadding: EdgeInsets.all(20.0),
                            ),
                            style: TextStyle(
                                color: Color(0xff333c8b), fontSize: 20.0),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFinalStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: isLoadingCalculated
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff333c8b)),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 40.0),
                      child: Text(
                        extimatedTo,
                        style: TextStyle(
                            color: Color(0xff333c8b),
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.only(left: 65.0, right: 65.0),
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xff333c8b)),
                          bottom: BorderSide(color: Color(0xff333c8b)),
                          left: BorderSide(color: Color(0xff333c8b)),
                          right: BorderSide(color: Color(0xff333c8b)),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: TextButton(
                      onPressed: () => {
                        setState(() {
                          curIndex = 0;

                          birthdateCtrl.text = "";
                          year1976_2001Ctrl.text = "";
                          year2002_todayCtrl.text = "";
                          year2002_2006Ctrl.text = "";
                          year2007_2009Ctrl.text = "";
                          year2007_todayCtrl.text = "";
                          year2010_todayCtrl.text = "";
                          salaireCtrl.text = "";
                          indiceCtrl.text = "";
                        }),
                      },
                      child: Text(
                        "Reprendre",
                        style: const TextStyle(
                            color: Color(0xff333c8b),
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: "Lato"),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () => {Navigator.pop(context)},
                      child: Text(
                        "Retourner à la connexion",
                        style: const TextStyle(
                            color: Color(0xff333c8b),
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: "Lato"),
                      )),
                ],
              ),
      ),
    );
  }

  calculateSolde() {
    int year = int.parse(birthdateCtrl.text.substring(6, 10));

    num age = DateTime.now().year - year;

    if (age < 60 && regime != "FNP") {
      setState(() {
        isLoadingCalculated = false;
        extimatedTo = "Vous devez avoir au moins 60ans";
      });
    } else if (age < 55 && regime == "FNP") {
      setState(() {
        isLoadingCalculated = false;
        extimatedTo = "Vous devez avoir au moins 55ans";
      });
    } else if (regime == "RG") {
      if ((int.parse(year1976_2001Ctrl.text) +
              int.parse(year2002_2006Ctrl.text) +
              int.parse(year2007_todayCtrl.text)) <
          25) {
        setState(() {
          isLoadingCalculated = false;
          extimatedTo = "Vous devez cotiser pour au moins 25ans";
        });
      } else {
        double tc1 = 0.02 * int.parse(year1976_2001Ctrl.text);
        double tc2 = 0.018 * int.parse(year2002_2006Ctrl.text);
        double tc3 = 0.015 * int.parse(year2007_todayCtrl.text);
        double tcc = tc1 + tc2 + tc3;

        double pensionBrute = int.parse(salaireCtrl.text) * tcc;
        var pensionNet = (pensionBrute > 50000)
            ? pensionBrute - (pensionBrute * 0.03)
            : pensionBrute;
        setState(() {
          isLoadingCalculated = false;
          extimatedTo = "Votre pension Net mensuelle est estimée à " +
              pensionNet.toString();
        });
      }
    } else if (regime == "DMG") {
      if ((int.parse(year1976_2001Ctrl.text) +
              int.parse(year2002_todayCtrl.text)) <
          25) {
        setState(() {
          isLoadingCalculated = false;
          extimatedTo = "Vous devez cotiser pour au moins 25ans";
        });
      } else {
        double tc1 = 0.04 * int.parse(year1976_2001Ctrl.text);
        double tc2 = 0.03 * int.parse(year2002_todayCtrl.text);
        double tcc = tc1 + tc2;

        double pensionAnnuelBrute =
            (int.parse(indiceCtrl.text) * tcc * 139.667) / 100;

        setState(() {
          isLoadingCalculated = false;
          extimatedTo = "Votre pension annuelle est estimée à " +
              pensionAnnuelBrute.toString();
        });
      }
    } else {
      if ((int.parse(year1976_2001Ctrl.text) +
              int.parse(year2002_2006Ctrl.text) +
              int.parse(year2007_2009Ctrl.text) +
              int.parse(year2010_todayCtrl.text)) <
          10) {
        setState(() {
          isLoadingCalculated = false;
          extimatedTo = "Vous devez cotiser pour au moins 2 mandats";
        });
      } else {
        double tc1 = 0.04 * int.parse(year1976_2001Ctrl.text);
        double tc2 = 0.03 * int.parse(year2002_2006Ctrl.text);
        double tc3 = 0.03 * int.parse(year2007_2009Ctrl.text);
        double tc4 = 0.03 * int.parse(year2010_todayCtrl.text);
        double tcc = tc1 + tc2 + tc3 + tc4;

        double pensionAnnuelBrute =
            (int.parse(indiceCtrl.text) * tcc * 139.667) / 100;

        setState(() {
          isLoadingCalculated = false;
          extimatedTo = "Votre pension annuelle est estimée à " +
              pensionAnnuelBrute.toString();
        });
      }
    }
  }
}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key? key,
      required this.controller,
      required this.screenWidth,
      required this.onStartAnimation})
      : width = Tween<double>(
          begin: screenWidth,
          end: screenWidth,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = Tween<BorderRadius>(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(2.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 3.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
//                color: Colors.blue,
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
                            //  color: Color(0xff333c8b),
                            color: index == 0 ? Color(0xff333c8b) : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 15.0) / 5.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
//                color: Colors.blue,
                      margin: EdgeInsets.only(top: 34.0),
//                height: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50.0),
                            child: Text(
                              'Quelle est votre date de Naissance ?',
                              style: TextStyle(
                                  color: Color(0xff333c8b),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 60.0),
                    child: Text(
                      'Simulateur de Pension de retraite',
                      style: TextStyle(
                          color: Color(0xff333c8b),
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                    child: Text(
                      'Pour connaître une estimation de votre pension de retraite, veuillez saisir correctement vos informations',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value,
                    child: GestureDetector(
                      child: Container(
                        height: height.value,
                        decoration: BoxDecoration(
                          color: Color(0xff333c8b),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Commencer',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
//            Opacity(
//              opacity: 1.0 - opacity.value,
//              child:
//            ),
          ],
        );
      },
    );
  }
}

class SecondQuestion {
  final String displayContent;
  bool isSelected;

  SecondQuestion(this.displayContent, this.isSelected);
}
