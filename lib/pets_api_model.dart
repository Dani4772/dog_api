// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class PetsApiModel {
  String name;
  String? description;
  List<Images> images;


  PetsApiModel({
    required this.name,
    required this.description,
    required this.images,
  });



  factory PetsApiModel.fromJson(Map<String, dynamic> json) => PetsApiModel(
    name: json["name"],
    description: json["description"],
    images:json['images'].map((e) => Images.fromJson(e)).toList().cast<Images>(),
  );
}

class Images {
  String src;

  Images({
    required this.src,
  });


  factory Images.fromJson(Map<String, dynamic> json) => Images(
    src: json["src"],
  );


}
