import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_autentication/models/alimentos.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class AlimentosProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref('alimentos');
  List<AlimentosDAO> bebidas = [];
  List<AlimentosDAO> comidas = [];
  List<AlimentosDAO> todos = [];

  AlimentosProvider() {
    getOnDisplayAlimentos();
  }

  getOnDisplayAlimentos() async {
    final documentReference = _firestore.collection('comida');
    final ref = await documentReference.withConverter(
        fromFirestore: AlimentosDAO.fromFirestore,
        toFirestore: (AlimentosDAO alimento, _) => alimento.toFirestore());
    final docSnamp = await ref.get();
    final alimentos = docSnamp.docs.map((e) => e.data()).toList();
    alimentos.forEach((element) {
      if (element.tipo == 'alimento') {
        comidas.add(element);
      } else {
        bebidas.add(element);
      }
      todos.add(element);
    });
    notifyListeners();
  }
}
