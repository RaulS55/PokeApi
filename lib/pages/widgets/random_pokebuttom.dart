import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokeapp/pages/home_controller.dart';
import 'package:pokeapp/utils/font_style.dart';
import 'package:pokeapp/utils/responsive.dart';
import 'package:provider/provider.dart';

class RandomButtom extends StatelessWidget {
  const RandomButtom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
        Provider.of<HomeController>(context, listen: false);
    final Responsive responsive = Responsive(context);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: 15, horizontal: responsive.wp(17))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.catching_pokemon),
            Text(
              "  RAMDOM POKEMON  ",
              style: MyStyle.whiteBold,
            ),
            Icon(Icons.catching_pokemon),
          ],
        ),
        onPressed: () {
          final random = Random();
          homeController.actuPoke(
            random.nextInt(151) + 1,
          );
        });
  }
}
