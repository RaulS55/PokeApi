import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/models/pokemon.dart';
import 'package:pokeapp/utils/responsive.dart';
import 'dart:math' as Math;

class PokeImagen extends StatefulWidget {
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
  State<PokeImagen> createState() => _PokeImagenState();
}

class _PokeImagenState extends State<PokeImagen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotacion;
  late Animation<double> agrandar;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    rotacion = Tween(begin: 0.0, end: 2.0 * Math.pi).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut));

    agrandar = Tween(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut));

    controller.addListener(() {
      //print("Status: ${controller.status}");
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
        //controller.reset();
      }
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget chil = GestureDetector(
      onDoubleTap: () {
        controller.forward();
      },
      child: Container(
          width: widget._responsive.dp(20),
          height: widget._responsive.dp(20),
          margin: EdgeInsets.symmetric(vertical: widget._responsive.hp(2)),
          padding: EdgeInsets.only(bottom: widget._responsive.dp(2)),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: SizedBox(
            width: widget._responsive.dp(17),
            child: CachedNetworkImage(
              imageUrl: widget._pokemon!.sprites.other!.home.frontDefault,
            ),
          )),
    );

    return AnimatedBuilder(
      animation: controller,
      child: chil,
      builder: (_, imagen) {
        return Transform.rotate(
          angle: rotacion.value,
          child: Transform.scale(scale: agrandar.value, child: imagen),
        );
      },
    );
  }
}
