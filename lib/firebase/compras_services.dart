import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_autentication/models/alimentos.dart';
import 'package:firebase_autentication/models/compras.dart';
import 'package:flutter/material.dart';

class ComprasProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ComprasDAO> compras = [];
  String id = '';

  setId(String id) {
    this.id = id;
  }

  getCompras() async {
    final documentReference = _firestore.collection('compras');
    final ref = await documentReference
        .where("idUsario", isEqualTo: id)
        .withConverter(
            fromFirestore: ComprasDAO.fromFirestore,
            toFirestore: (ComprasDAO compra, _) => compra.toFirestore());
    final docSnamp = await ref.get();
    compras = docSnamp.docs.map((e) => e.data()).toList();
    notifyListeners();
  }

  createCompras(ComprasDAO compra) async {
    DocumentReference documentReference =
        _firestore.collection('compras').doc();
    documentReference.set({
      'fecha': compra.fecha,
      'idUsario': compra.idUsario,
      'idproducto': compra.idproducto,
      'precio': compra.precio,
    }, SetOptions(merge: true));
    getCompras();
  }

  AlimentosDAO getAlimento(List<AlimentosDAO> todos, String id) {
    AlimentosDAO alimento = todos.firstWhere((element) => element.id == id);
    return alimento;
  }
}
