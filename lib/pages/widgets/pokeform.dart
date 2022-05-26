import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokemon.dart';
import 'package:pokeapp/pages/widgets/color_poke.dart';
import 'package:pokeapp/utils/font_style.dart';

class PokeForm extends StatelessWidget {
  const PokeForm({Key? key, required this.pokemon}) : super(key: key);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return CupertinoFormSection.insetGrouped(
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(15).copyWith(top: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colores(pokemon).color(),
      ),
      header: const Text(""),
      children: [
        CupertinoFormRow(
          prefix: const Text("Id:", style: MyStyle.whiteNormal),
          child: Text(pokemon.id.toString(), style: MyStyle.whiteNormal),
        ),
        CupertinoFormRow(
          prefix: const Text("Nombre:", style: MyStyle.whiteNormal),
          child: Text(pokemon.name.toString(), style: MyStyle.whiteNormal),
        ),
        CupertinoFormRow(
          prefix: const Text("Tipo:", style: MyStyle.whiteNormal),
          child: Text(pokemon.types[0].type.name.toString(),
              style: MyStyle.whiteNormal),
        ),
        CupertinoFormRow(
          prefix: const Text("Stats Base:", style: MyStyle.whiteNormal),
          child: Text(pokemon.stats[0].baseStat.toString(),
              style: MyStyle.whiteNormal),
        ),
      ],
    );
  }
}
