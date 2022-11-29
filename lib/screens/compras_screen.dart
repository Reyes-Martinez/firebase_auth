import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_autentication/firebase/compras_services.dart';
import 'package:firebase_autentication/models/alimentos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/alimentos_provider.dart';

class ComprasScreen extends StatelessWidget {
  const ComprasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final compraProvider = Provider.of<ComprasProvider>(context);
    final alimentosProvider = Provider.of<AlimentosProvider>(context);

    return Scaffold(
        body: compraProvider.compras.isEmpty
            ? const Center(child: Text("No tienes nungula compra"))
            : ListView.builder(
                itemCount: compraProvider.compras.length,
                itemBuilder: (_, i) => Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.amber,
                      ),
                      onDismissed: (DismissDirection direction) {
                        print('se borro ${compraProvider.compras[i].fecha}');
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 239, 182, 135),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_cart,
                              size: 45,
                              color: Color.fromARGB(255, 255, 255, 255)),
                          title: Text(
                              "Fecha de compra: ${compraProvider.compras[i].fecha}"),
                          subtitle: Text(
                              "Total: ${compraProvider.compras[i].precio}"),
                          onTap: () async {
                            AlimentosDAO alimento = compraProvider.getAlimento(
                                alimentosProvider.todos,
                                compraProvider.compras[i].idproducto);
                            // ignore: use_build_context_synchronously
                            ElegantNotification.info(
                                    title: const Text("Detalle de compra"),
                                    description:
                                        Text("Compraste:\n${alimento.nombre}"))
                                .show(context);
                          },
                        ),
                      ),
                    )));
  }
}
