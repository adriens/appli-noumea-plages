import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noumea_plages/drapeau.dart';

class Plage {
  String couleurDrapeau;
  String nomPlage;
  String urlIconeDrapeau;
  int plageId;
  String baignadeMessage;
  String couleurDrapeauEnglish;
  String videoStreamURL;

  Plage(
      {this.couleurDrapeau,
        this.nomPlage,
        this.urlIconeDrapeau,
        this.plageId,
        this.baignadeMessage,
        this.couleurDrapeauEnglish,
        this.videoStreamURL});

  factory Plage.fromJson(Map<String, dynamic> json) =>
    new Plage(
        couleurDrapeau: json['couleurDrapeau'],
        nomPlage: json['nomPlage'],
        urlIconeDrapeau: json['urlIconeDrapeau'],
        plageId: json['plageId'],
        baignadeMessage: json['baignadeMessage'],
        couleurDrapeauEnglish: json['couleurDrapeauEnglish'],
        videoStreamURL: json['videoStreamURL']);

  static Color getFlagColor(Plage plage) {
    Color color;
    switch (plage.couleurDrapeau) {
      case "BLEU": color = Colors.blueAccent; break;
      case "JAUNE": color = Colors.yellowAccent; break;
      case "ROUGE": color = Colors.red; break;
      default: color = Colors.grey; break;
    }
    return color;
  }

}