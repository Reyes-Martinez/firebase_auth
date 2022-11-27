import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_autentication/firebase/compras_services.dart';
import 'package:firebase_autentication/models/alimentos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../firebase/user_services.dart';
import '../models/compras.dart';

class AlimentoDetailScreen extends StatelessWidget {
  const AlimentoDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlimentosDAO alimento =
        ModalRoute.of(context)!.settings.arguments as AlimentosDAO;

    final RoundedLoadingButtonController btnController =
        RoundedLoadingButtonController();

    final compraProvider = Provider.of<ComprasProvider>(context);
    final userProvider = Provider.of<UserServices>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            image: alimento.imagen,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(
              height: 20,
            ),
            _Name(
              name: alimento.nombre,
              descripcion: alimento.descripcion,
              precio: alimento.precio,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              color: Colors.blue,
              borderRadius: 10,
              controller: btnController,
              errorColor: Colors.red,
              onPressed: () async {
                final compra = ComprasDAO(
                    fecha: DateTime.now(),
                    idUsario: userProvider.userDAO.id!,
                    idproducto: alimento.id,
                    precio: alimento.precio);
                compraProvider.createCompras(compra);
                ElegantNotification.success(
                        title: const Text("Compra exitosa"),
                        description:
                            const Text("Tu compra se ha realizado con exito"))
                    .show(context);
                await Future.delayed(const Duration(seconds: 2)).then((value) {
                  btnController.reset();
                  Navigator.pushReplacementNamed(context, '/home');
                });
              },
              child: const Text('Compar'),
            ),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String image;
  const _CustomAppBar({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        background: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  final String name;
  final String descripcion;
  final double precio;
  const _Name({
    Key? key,
    required this.name,
    required this.descripcion,
    required this.precio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$name ${precio}MXN',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              descripcion,
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
