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
                child: Stack(children: [
                  SizedBox(
                    width: double.infinity - padding.top - padding.bottom,
                    height: responsive.hp(90),
                    child: CustomPaint(
                      painter: _HeaderCurvo(homeController),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(height: responsive.hp(2)),
                        Text(
                          homeController.selectPoke.name,
                          style: MyStyle.title
                              .copyWith(fontSize: responsive.dp(5)),
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
                  )
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeaderCurvo extends CustomPainter {
  final homeController;

  _HeaderCurvo(this.homeController);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint lapiz = Paint();
    lapiz.color = Colores(homeController.selectPoke).color();
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 5;

    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.40);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.55, size.width, size.height * 0.40);
    path.lineTo(size.width, size.height * 0.40);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
