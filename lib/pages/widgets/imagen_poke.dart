import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokemon.dart';
import 'package:pokeapp/utils/responsive.dart';

class PokeImagen extends StatelessWidget {
  const PokeImagen({
    Key? key,
    required Responsive responsive,
    required Pokemon? pokemon,
  })  : _responsive = responsive,
        _pokemon = pokemon,
        super(key: key);

  final Responsive _responsive;
  final Pokemon? _pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: _responsive.dp(20),
        height: _responsive.dp(20),
        margin: EdgeInsets.symmetric(vertical: _responsive.hp(2)),
        padding: EdgeInsets.only(bottom: _responsive.dp(2)),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        //GIF
        child: SizedBox(
          width: _responsive.dp(17),
          child: CachedNetworkImage(
            imageUrl: _pokemon!.sprites.other!.home.frontDefault,
          ),
        ));
  }
}
