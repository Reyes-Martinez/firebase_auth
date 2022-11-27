import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComprasDAO {
  final DateTime fecha;
  final String idUsario;
  final String idproducto;
  final double precio;

  ComprasDAO({
    required this.idUsario,
    required this.idproducto,
    required this.precio,
    required this.fecha,
  });

  factory ComprasDAO.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ComprasDAO(
      idUsario: data?['idUsario'],
      idproducto: data?['idproducto'],
      precio: data?['precio'],
      fecha: data?['fecha'].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (idUsario != null) "idUsario": idUsario,
      if (idproducto != null) "idproducto": idproducto,
      if (precio != null) "precio": precio,
      if (fecha != null) "fecha": fecha,
    };
  }
}
