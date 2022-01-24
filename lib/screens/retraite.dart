import 'dart:convert';
import 'package:cnss_djibouti_app/widget/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

// ignore: camel_case_types
class RetraiteScreen extends StatefulWidget {
  const RetraiteScreen({
    Key? key,
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
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
            future: getSampleTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final task = snapshot.data!;
                return SurveyKit(
                  onResult: (SurveyResult result) {
                    print(result.finishReason);
                  },
                  task: task,
                  showProgress: true,
                  localizations: {
                    'cancel': 'Annuler',
                    'next': 'Suivant',
                  },
                  themeData: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.blue,
                    ).copyWith(
                      onPrimary: Colors.white,
                    ),
                    primaryColor: Color(0xff333c8b),
                    backgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      iconTheme: IconThemeData(
                        color: Color(0xff333c8b),
                      ),
                      titleTextStyle: TextStyle(
                        color: Color(0xff333c8b),
                      ),
                    ),
                    iconTheme: const IconThemeData(
                      color: Color(0xff333c8b),
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Color(0xff333c8b),
                      selectionColor: Color(0xff333c8b),
                      selectionHandleColor: Color(0xff333c8b),
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      primaryColor: Color(0xff333c8b),
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(150.0, 60.0),
                        ),
                        side: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return BorderSide(
                                color: Colors.grey,
                              );
                            }
                            return BorderSide(
                              color: Color(0xff333c8b),
                            );
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textStyle: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                    color: Colors.grey,
                                  );
                            }
                            return Theme.of(context).textTheme.button?.copyWith(
                                  color: Color(0xff333c8b),
                                );
                          },
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.button?.copyWith(
                                color: Color(0xff333c8b),
                              ),
                        ),
                      ),
                    ),
                    textTheme: TextTheme(
                      headline2: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                      ),
                      headline5: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      bodyText2: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      subtitle1: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  surveyProgressbarConfiguration: SurveyProgressConfiguration(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ),
    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Simulateur de \nPension de retraite',
          text:
              'Pour connaître une estimation de votre pension de retraite, veuillez saisir correctement vos informations',
          buttonText: "Commencer",
        ),
        QuestionStep(
          title: 'Quelle est votre date de Naissance ?',
          answerFormat: DateAnswerFormat(
            minDate: DateTime.utc(1970),
            maxDate: DateTime.now(),
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'A quel régime cotisez-vous ?',
          text: '',
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'RG', value: 'RG'),
              TextChoice(text: 'FCT', value: 'FCT'),
              TextChoice(text: 'FNP', value: 'FNP'),
              TextChoice(text: 'DMG', value: 'DMG'),
            ],
          ),
          isOptional: false,
        ),
        QuestionStep(
            title:
                'Pendant combien d\'années avez-vous travaillé entre 1976 et 2001 ?',
            answerFormat: IntegerAnswerFormat(),
            isOptional: false),
        QuestionStep(
            title:
                'Pendant combien d\'années avez-vous travaillé entre 2002 et 2007 ?',
            answerFormat: IntegerAnswerFormat(),
            isOptional: false),
        QuestionStep(
          title:
              'Pendant combien d\'années avez-vous travaillé de 2008 à aujourd\'hui ?',
          isOptional: false,
          answerFormat: IntegerAnswerFormat(),
        ),
        QuestionStep(
          title:
              'Indiquez la moyenne de votre salaire brut mensuel des 10 dernères années',
          isOptional: false,
          answerFormat: IntegerAnswerFormat(),
        ),
        QuestionStep(
          title: 'Indice du solde',
          answerFormat: IntegerAnswerFormat(),
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'Merci!',
          title: 'Fait!',
          buttonText: 'Simuler',
        ),
      ],
    );
/*     task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].stepIdentifier;
            case "No":
              return task.steps[7].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    ); */
    return Future.value(task);
  }
}
