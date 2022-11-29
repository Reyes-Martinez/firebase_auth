import 'package:firebase_autentication/models/alimentos.dart';
import 'package:firebase_autentication/widgets/item_component.dart';
import 'package:flutter/material.dart';

class AlimentosSlider extends StatefulWidget {
  final List<AlimentosDAO> alimentos;
  final String? title;
  final Function onNextPage;
  const AlimentosSlider(
      {Key? key, required this.alimentos, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<AlimentosSlider> createState() => _AlimentosSliderState();
}

class _AlimentosSliderState extends State<AlimentosSlider> {
  final ScrollController scrolCintroller = ScrollController();

  @override
  void initState() {
    super.initState();
    scrolCintroller.addListener(() {
      if (scrolCintroller.position.pixels >=
          scrolCintroller.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  widget.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              controller: scrolCintroller,
              scrollDirection: Axis.horizontal,
              itemCount: widget.alimentos.length,
              itemBuilder: (_, int index) {
                final alimento = widget.alimentos[index];
                return _AlimentoPoster(
                  alimento: alimento,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _AlimentoPoster extends StatelessWidget {
  final AlimentosDAO alimento;
  const _AlimentoPoster({Key? key, required this.alimento}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 310,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/details", arguments: alimento);
            },
            child: Hero(
              tag: alimento.id,
              child: ItemComponent(
                  img: alimento.imagen,
                  nombre: alimento.nombre,
                  precio: alimento.precio),
            ),
          ),
        ],
      ),
    );
  }
}
