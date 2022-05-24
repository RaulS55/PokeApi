import 'package:flutter/cupertino.dart';
import 'package:pokeapp/models/pokemon.dart';

class Colores {
  final Pokemon _pokemon;

  Colores(this._pokemon);

  Color color() {
    final color = _pokemon.types[0].type.name;
    switch (color) {
      case "bug":
        return const Color(0xFFA8B820);
      case "dart":
        return const Color(0xFF705848);
      case "electric":
        return const Color(0xFFF8D030);
      case "fairy":
        return const Color(0xFFEE99AC);
      case "ice":
        return const Color(0xFF98D8D8);
      case "ghost":
        return const Color(0xFF705898);
      case "poison":
        return const Color(0xFFA040A0);
      case "rock":
        return const Color(0xFFB8A038);
      case "steel":
        return const Color(0xFFB8B8D0);
      case "tcg":
        return const Color(0xFFE5D6D0);
      case "water":
        return const Color(0xFF6890F0);
      case "fire":
        return const Color(0xFFF08030);
      case "fighting":
        return const Color(0xFFC03028);
      case "dragon":
        return const Color(0xFF7038F8);
      case "flying":
        return const Color(0xFFA890F0);
      case "grass":
        return const Color(0xFF78C850);
      case "ground":
        return const Color(0xFFE0C068);
      case "psychic":
        return const Color(0xFFF85888);
    }
    return const Color(0xFFA8A878);
  }
}
