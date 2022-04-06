import 'dart:convert';

List<CotisantAssure> postFromJson(String str) => List<CotisantAssure>.from(
    json.decode(str).map((x) => CotisantAssure.fromMap(x)));

class CotisantAssure {
  CotisantAssure(
      {required this.id,
      required this.matricule_externe,
      required this.compte_cotisant,
      required this.nom,
      required this.compte_assure,
      required this.nomAssure,
      required this.regime,
      required this.salaire,
      required this.SSN,
      required this.date_d_embauche,
      required this.date_de_rupture});

  int id;
  String? matricule_externe;
  String? compte_cotisant;
  String? nom;
  String? compte_assure;
  String? nomAssure;
  String? regime;
  String? salaire;
  String? SSN;
  String? date_d_embauche;
  String? date_de_rupture;

  factory CotisantAssure.fromMap(Map<String, dynamic> json) => CotisantAssure(
        id: json["id"],
        matricule_externe: json["matricule_externe"],
        compte_cotisant: json["compte_cotisant"],
        nom: json["nom"],
        compte_assure: json["Compte assure"],
        nomAssure: json["Nom Assure"],
        regime: json["regime"],
        salaire: json["salaire_brut"],
        SSN: json["ssn"],
        date_d_embauche: json["date_d_embauche"],
        date_de_rupture: json["date_de_rupture"],
      );
}
