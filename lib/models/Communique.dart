import 'dart:convert';

List<Communique> postFromJson(String str) =>
    List<Communique>.from(json.decode(str).map((x) => Communique.fromMap(x)));

class Communique {
  Communique({
    required this.id,
    required this.title,
    required this.body,
    //required this.image,
    required this.created_at,
    required this.updated_at
  });

  int id;
  String? title;
  String? body;
  //String image;
  String? created_at;
  String? updated_at;

  factory Communique.fromMap(Map<String, dynamic> json) => Communique(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    //image: json["image"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
  );
}