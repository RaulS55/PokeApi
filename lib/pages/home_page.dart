import 'package:flutter/material.dart';
import 'package:pokeapp/pages/home_controller.dart';
import 'package:pokeapp/pages/widgets/arrow_selector.dart';
import 'package:pokeapp/pages/widgets/color_poke.dart';
import 'package:pokeapp/pages/widgets/imagen_poke.dart';
import 'package:pokeapp/pages/widgets/pokeform.dart';
import 'package:pokeapp/pages/widgets/random_pokebuttom.dart';
import 'package:pokeapp/pages/widgets/seach.dart';
import 'package:pokeapp/utils/font_style.dart';
import 'package:pokeapp/utils/responsive.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final padding = MediaQuery.of(context).padding;

    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      builder: (_, __) {
        final homeController = Provider.of<HomeController>(_);
        if (homeController.pokemons.isEmpty) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Colores(homeController.selectPoke).color(),
                  height: responsive.height - padding.top,
                  child: Column(
                    children: [
                      SizedBox(height: responsive.hp(5)),
                      Text(
                        homeController.selectPoke.name,
                        style:
                            MyStyle.title.copyWith(fontSize: responsive.dp(5)),
                      ),
                      PokeImagen(
                          responsive: responsive,
                          pokemon: homeController.selectPoke),

                      //FLECHAS
                      const SelectorPoke(),
                      PokeForm(pokemon: homeController.selectPoke),
                      PokeSeach(),
                      const RandomButtom()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
