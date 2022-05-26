import 'package:flutter/material.dart';
import 'package:pokeapp/pages/home_controller.dart';
import 'package:pokeapp/utils/font_style.dart';
import 'package:provider/provider.dart';

class SelectorPoke extends StatelessWidget {
  const SelectorPoke({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
        Provider.of<HomeController>(context, listen: false);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
            child: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (homeController.selectPoke.id > 1) {
                homeController.actuPoke(
                  homeController.selectPoke.id - 1,
                );
              }
            }),
        Consumer<HomeController>(
          builder: (_, controller, __) => Text(
            " ${(controller.selectPoke.id)} ",
            style: MyStyle.id,
          ),
        ),
        ElevatedButton(
            child: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if (homeController.selectPoke.id < 152) {
                homeController.actuPoke(
                  homeController.selectPoke.id + 1,
                );
              }
            })
      ],
    );
  }
}
