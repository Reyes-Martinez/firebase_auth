import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_autentication/models/alimentos.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';

class AlimentosProvider extends ChangeNotifier {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('alimentos');
  List<AlimentosDAO> bebidas = [];
  List<AlimentosDAO> comidas = [];

  AlimentosProvider() {
    getOnDisplayAlimentos();
  }

  getOnDisplayAlimentos() async {
    // comidas = await checkUser();
    // print(comidas);
  }

  // Future checkUser() async {
  //   try {
  //     DataSnapshot data =
  //         await FirebaseDatabase.instance.ref('alimentos').get();
  //     if (data.value != null) {
  //       //FirebaseUser.fromJson(data.value) returns error as type cast error
  //       // '_InternalLinkedHashMap<Object?, Object?>'
  //       //is not a subtype of type 'Map<String, dynamic>
  //       return AlimentosDAO.fromJson((jsonEncode(data.value)));
  //     } else {
  //       return null;
  //     }
  //   } on FirebaseException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
