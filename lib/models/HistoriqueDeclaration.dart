import 'dart:convert';

List<HistoriqueDeclaration> postFromJson(String str) =>
    List<HistoriqueDeclaration>.from(
        json.decode(str).map((x) => HistoriqueDeclaration.fromMap(x)));

class HistoriqueDeclaration {
  HistoriqueDeclaration({
    required this.numeroAppelDeCotisation,
    required this.compteCotisant,
    required this.compteAssur,
    required this.nomAssur,
    required this.salaireIndiciaireDClare,
    required this.salaireIndiciaireclRevis,
    required this.dateDeCrAtion,
    required this.crErPar,
    required this.matriculeExterne,
    required this.joursTravaillees,
    required this.salaireBrutAttendue,
    required this.salaireBrutDeclare,
    required this.salaireBrutRevise,
    required this.statuts,
    required this.statutDeRevision,
    required this.multiPeriode,
    required this.typeDAppelDeCotisation,
    required this.dateDeDeclaration,
    required this.regime,
    required this.periode,
    required this.ruptureProbable,
    required this.heuresTravaillees,
    required this.typeDeCotisation,
    required this.statutDePaiement,
    required this.rECID,
    required this.identifiantHDDW,
    required this.sSN,
  });

  String? numeroAppelDeCotisation;
  String? compteCotisant;
  String? compteAssur;
  String? nomAssur;
  String? salaireIndiciaireDClare;
  String? salaireIndiciaireclRevis;
  String? dateDeCrAtion;
  String? crErPar;
  String? matriculeExterne;
  String? joursTravaillees;
  String? salaireBrutAttendue;
  String? salaireBrutDeclare;
  String? salaireBrutRevise;
  String? statuts;
  String? statutDeRevision;
  String? multiPeriode;
  String? typeDAppelDeCotisation;
  String? dateDeDeclaration;
  String? regime;
  String? periode;
  String? ruptureProbable;
  String? heuresTravaillees;
  String? typeDeCotisation;
  String? statutDePaiement;
  String? rECID;
  String? identifiantHDDW;
  String? sSN;

  factory HistoriqueDeclaration.fromMap(Map<String, dynamic> json) =>
      HistoriqueDeclaration(
        numeroAppelDeCotisation: json['Numero Appel de Cotisation'],
        compteCotisant: json['Compte Cotisant'],
        compteAssur: json['Compte Assuré'],
        nomAssur: json['Nom Assuré'],
        salaireIndiciaireDClare: json['Salaire indiciaire déclare'],
        salaireIndiciaireclRevis: json['Salaire indiciairecl Revisé'],
        dateDeCrAtion: json['Date de Création'],
        crErPar: json['Créer par'],
        matriculeExterne: json['Matricule externe'],
        joursTravaillees: json['Jours Travaillees'],
        salaireBrutAttendue: json['Salaire brut attendue'],
        salaireBrutDeclare: json['Salaire brut declare'],
        salaireBrutRevise: json['Salaire brut revise'],
        statuts: json['Statuts'],
        statutDeRevision: json['Statut de revision'],
        multiPeriode: json['Multi periode'],
        typeDAppelDeCotisation: json["Type d'appel de cotisation"],
        dateDeDeclaration: json['Date de declaration'],
        regime: json['Regime'],
        periode: json['Periode'],
        ruptureProbable: json['Rupture probable'],
        heuresTravaillees: json['Heures Travaillees'],
        typeDeCotisation: json['Type de Cotisation'],
        statutDePaiement: json['Statut de paiement'],
        rECID: json['RECID'],
        identifiantHDDW: json['Identifiant_HD_DW'],
        sSN: json['SSN'],
      );
}
