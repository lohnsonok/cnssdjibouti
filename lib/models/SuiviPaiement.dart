import 'dart:convert';

List<SuiviPaiement> postFromJson(String str) => List<SuiviPaiement>.from(
    json.decode(str).map((x) => SuiviPaiement.fromMap(x)));

class SuiviPaiement {
  SuiviPaiement(
      {this.numeroAppelDeCotisation,
      this.periode,
      this.compteCotisant,
      this.nomDuCotisant,
      this.secteurDActivite,
      this.sousSecteurDActivite,
      this.statut,
      this.statutDePaiement,
      this.statutDeRevision,
      this.codeLettreDeRelance,
      this.date_d_echeance,
      this.dateDeDeclaration,
      this.cotisation,
      this.pSAMO,
      this.pSVieillesse,
      this.pSAccidentDeTravail,
      this.pSPrestationFamilliale,
      this.pPPrestationFamilliale,
      this.pPAMO,
      this.pPVieillesse,
      this.pPAccidentDeTravail,
      this.montantRedressement,
      this.astreinte,
      this.majoration3,
      this.majoration10,
      this.tOTAL,
      this.dateDePaiement,
      this.modeDePaiement,
      this.compteBancaire,
      this.referenceDePaiement,
      this.solde,
      this.nombreDesSalariesDeclares,
      this.montantRegler,
      this.masseSalariale,
      this.multiPeriode,
      this.regime,
      this.statutEmployeur,
      this.typeDeCotisant,
      this.creePar,
      this.nombreDesSalariesAttendue,
      this.cotisationDeclare,
      this.cotisationAttendue,
      this.dateEtHeureDeCreation,
      this.typeDeAppelDeCotisation});

  String? numeroAppelDeCotisation;
  String? periode;
  String? compteCotisant;
  String? nomDuCotisant;
  String? secteurDActivite;
  String? sousSecteurDActivite;
  String? statut;
  String? statutDePaiement;
  String? statutDeRevision;
  String? codeLettreDeRelance;
  String? date_d_echeance;
  String? dateDeDeclaration;
  String? cotisation;
  String? pSAMO;
  String? pSVieillesse;
  String? pSAccidentDeTravail;
  String? pSPrestationFamilliale;
  String? pPPrestationFamilliale;
  String? pPAMO;
  String? pPVieillesse;
  String? pPAccidentDeTravail;
  String? montantRedressement;
  String? astreinte;
  String? majoration3;
  String? majoration10;
  String? tOTAL;
  String? dateDePaiement;
  String? modeDePaiement;
  String? compteBancaire;
  String? referenceDePaiement;
  String? solde;
  String? nombreDesSalariesDeclares;
  String? montantRegler;
  String? masseSalariale;
  String? multiPeriode;
  String? regime;
  String? statutEmployeur;
  String? typeDeCotisant;
  String? creePar;
  String? nombreDesSalariesAttendue;
  String? cotisationDeclare;
  String? cotisationAttendue;
  String? dateEtHeureDeCreation;
  String? typeDeAppelDeCotisation;

  factory SuiviPaiement.fromMap(Map<String, dynamic> json) => SuiviPaiement(
        numeroAppelDeCotisation: json['Numero appel de cotisation'],
        periode: json['Période'],
        compteCotisant: json['Compte cotisant'],
        nomDuCotisant: json['Nom du cotisant'],
        secteurDActivite: json['Secteur d activite'],
        sousSecteurDActivite: json['Sous-secteur d activite'],
        statut: json['Statut'],
        statutDePaiement: json['Statut de paiement'],
        statutDeRevision: json['Statut de revision'],
        codeLettreDeRelance: json['Code lettre de relance'],
        date_d_echeance: json['Date d echéance'],
        dateDeDeclaration: json['Date de declaration'],
        cotisation: json['Cotisation'],
        pSAMO: json['PS AMO'],
        pSVieillesse: json['PS Vieillesse'],
        pSAccidentDeTravail: json['PS Accident de Travail'],
        pSPrestationFamilliale: json['PS Prestation familliale'],
        pPPrestationFamilliale: json['PP Prestation familliale'],
        pPAMO: json['PP AMO'],
        pPVieillesse: json['PP Vieillesse'],
        pPAccidentDeTravail: json['PP Accident de Travail'],
        montantRedressement: json['Montant redressement'],
        astreinte: json['Astreinte'],
        majoration3: json['Majoration 3%'],
        majoration10: json['Majoration 10%'],
        tOTAL: json['TOTAL'],
        dateDePaiement: json['Date de paiement'],
        modeDePaiement: json['Mode de paiement'],
        compteBancaire: json['Compte Bancaire'],
        referenceDePaiement: json['Reference de paiement'],
        solde: json['Solde'],
        nombreDesSalariesDeclares: json['Nombre des salaries declares'],
        montantRegler: json['Montant regler'],
        masseSalariale: json['Masse salariale'],
        multiPeriode: json['Multi periode'],
        regime: json['Regime'],
        statutEmployeur: json['Statut Employeur'],
        typeDeCotisant: json['Type de cotisant'],
        creePar: json['Cree par'],
        nombreDesSalariesAttendue: json['Nombre des salaries attendue'],
        cotisationDeclare: json['Cotisation declare'],
        cotisationAttendue: json['Cotisation attendue'],
        dateEtHeureDeCreation: json['Date et heure de creation'],
        typeDeAppelDeCotisation: json['Type de Appel de Cotisation'],
      );
}
