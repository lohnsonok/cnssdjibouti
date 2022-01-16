import 'dart:convert';

List<AppelCotisation> postFromJson(String str) => List<AppelCotisation>.from(
    json.decode(str).map((x) => AppelCotisation.fromMap(x)));

class AppelCotisation {
  AppelCotisation(
      {required this.numero_appel_de_cotisation,
      required this.compte_cotisant,
      required this.statut_de_paiement,
      required this.nom,
      required this.periode,
      required this.regime,
      required this.multi_periode,
      required this.date_d_echeance,
      required this.date_de_declaration,
      required this.statut_de_revision,
      required this.statut});

  String? numero_appel_de_cotisation;
  String? compte_cotisant;
  String? statut_de_paiement;
  String? nom;
  String? periode;
  String? regime;
  String? multi_periode;
  String? date_d_echeance;
  String? date_de_declaration;
  String? statut_de_revision;
  String? statut;

  factory AppelCotisation.fromMap(Map<String, dynamic> json) => AppelCotisation(
        numero_appel_de_cotisation: json["numéro_appel_de_cotisation"],
        compte_cotisant: json["compte_cotisant"],
        statut_de_paiement: json["statut_de_paiement"],
        nom: json["nom"],
        periode: json["periode"],
        regime: json["regime"],
        multi_periode: json["multi_periode"],
        date_d_echeance: json["date_d_echeance"],
        date_de_declaration: json["date_de_declaration"],
        statut_de_revision: json["statut_de_revision"],
        statut: json["statut"],
      );
}
