import 'package:flutter/material.dart';

class ItemComponent extends StatelessWidget {
  const ItemComponent(
      {super.key,
      required this.img,
      required this.precio,
      required this.nombre});
  final String img;
  final double precio;
  final String nombre;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 190,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      img,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            nombre,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            "${precio} MXN",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
