import 'dart:convert';

List<SuiviPaiement> postFromJson(String str) => List<SuiviPaiement>.from(
    json.decode(str).map((x) => SuiviPaiement.fromMap(x)));

class SuiviPaiement {
  SuiviPaiement({
    required this.periode,
    required this.compte_cotisant,
    required this.numero_appel_de_cotisation,
    required this.nom,
    required this.statut,
    required this.date_d_echeance,
    required this.cotisation,
    required this.total,
    required this.solde,
  });

  String periode;
  String compte_cotisant;
  String numero_appel_de_cotisation;
  String nom;
  String statut;
  String date_d_echeance;
  String cotisation;
  String total;
  String solde;

  factory SuiviPaiement.fromMap(Map<String, dynamic> json) => SuiviPaiement(
        periode: json["période"],
        compte_cotisant: json["compte_cotisant"],
        numero_appel_de_cotisation: json["numéro appel de cotisation"],
        nom: json["nom"],
        statut: json["statut"],
        date_d_echeance: json["date_d'échéance"],
        cotisation: json["cotisation"],
        total: json["total"],
        solde: json["solde"],
      );
}
