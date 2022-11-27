// To parse this JSON data, do
//
//     final alimentosDAO = alimentosDAOFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AlimentosDAO {
  AlimentosDAO({
    required this.imagen,
    required this.descripcion,
    required this.id,
    required this.nombre,
    required this.precio,
    required this.tipo,
  });

  final String descripcion;
  final String id;
  final String nombre;
  final double precio;
  final String tipo;
  final String imagen;

  factory AlimentosDAO.fromJson(String str) =>
      AlimentosDAO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlimentosDAO.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AlimentosDAO(
        descripcion: data?["descripcion"],
        id: data?["id"],
        nombre: data?["nombre"],
        precio: data?["precio"],
        tipo: data?["tipo"],
        imagen: data?["imagen"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (descripcion != null) "descripcion": descripcion,
      if (id != null) "id": id,
      if (nombre != null) "nombre": nombre,
      if (precio != null) "precio": precio,
      if (imagen != null) "imagen": imagen,
      if (tipo != null) "tipo": tipo,
    };
  }

  factory AlimentosDAO.fromMap(Map<String, dynamic> json) => AlimentosDAO(
      descripcion: json["descripcion"],
      id: json["id"],
      nombre: json["nombre"],
      precio: json["precio"],
      tipo: json["tipo"],
      imagen: json["imagen"]);

  Map<String, dynamic> toMap() => {
        "descripcion": descripcion,
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "tipo": tipo,
        "imagen": imagen
      };
}
