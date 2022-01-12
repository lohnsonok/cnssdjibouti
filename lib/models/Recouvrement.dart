import 'dart:convert';

List<Recouvrement> postFromJson(String str) => List<Recouvrement>.from(
    json.decode(str).map((x) => Recouvrement.fromMap(x)));

class Recouvrement {
  Recouvrement(
      {required this.id_dossier,
      required this.description,
      required this.compte_cotisant,
      required this.nom,
      required this.statut,
      required this.date_et_heure_de_modification});

  String id_dossier;
  String description;
  String compte_cotisant;
  String nom;
  String statut;
  String date_et_heure_de_modification;

  factory Recouvrement.fromMap(Map<String, dynamic> json) => Recouvrement(
        id_dossier: json["id_dossier"],
        description: json["description"],
        compte_cotisant: json["compte_cotisant"],
        nom: json["nom"],
        statut: json["statut"],
        date_et_heure_de_modification: json["date_et_heure_de_modification"],
      );
}
