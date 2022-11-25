// To parse this JSON data, do
//
//     final alimentosDAO = alimentosDAOFromMap(jsonString);

import 'dart:convert';

class AlimentosDAO {
  AlimentosDAO({
    required this.imagen,
    required this.cantidad,
    required this.descipcion,
    required this.id,
    required this.nombre,
    required this.precio,
    required this.tipo,
  });

  final int cantidad;
  final String descipcion;
  final int id;
  final String nombre;
  final double precio;
  final String tipo;
  final String imagen;

  factory AlimentosDAO.fromJson(String str) =>
      AlimentosDAO.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlimentosDAO.fromMap(Map<String, dynamic> json) => AlimentosDAO(
      cantidad: json["cantidad"],
      descipcion: json["descipcion"],
      id: json["id"],
      nombre: json["nombre"],
      precio: json["precio"],
      tipo: json["tipo"],
      imagen: json["imagen"]);

  Map<String, dynamic> toMap() => {
        "cantidad": cantidad,
        "descipcion": descipcion,
        "id": id,
        "nombre": nombre,
        "precio": precio,
        "tipo": tipo,
        "imagen": imagen
      };
}
