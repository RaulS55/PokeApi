import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pokeapp/helper/http.dart';
import 'package:pokeapp/pages/home_controller.dart';
import 'package:pokeapp/pages/widgets/color_poke.dart';
import 'package:pokeapp/utils/font_style.dart';
import 'package:pokeapp/utils/responsive.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PokeSeach extends StatelessWidget {
  PokeSeach({Key? key}) : super(key: key);
  int _value = 1;

  final httpoke = GetIt.instance<Http>();

  void _submit(Http httpoke, HomeController homeController) {
    final isFormOk = homeController.formKey.currentState!.validate();
    if (isFormOk) homeController.actuPoke(_value);
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    final pokemons = homeController.pokemons;
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.all(15).copyWith(bottom: 35),
      child: Form(
          key: homeController.formKey,
          child: TextFormField(
            onChanged: (value) {
              if (value.isNotEmpty) _value = int.parse(value);
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
            ],
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                label: const Text("Buscar por ID"),
                suffixIcon: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.search,
                      size: responsive.wp(7),
                      color: Colores(pokemons[homeController.count]).color(),
                    ),
                    onPressed: () => _submit(httpoke, homeController)),
                fillColor: Colors.white,
                filled: true),
            cursorColor: Colores(pokemons[homeController.count]).color(),
            style: MyStyle.bold,
            onFieldSubmitted: (v) => _submit(httpoke, homeController),
            validator: (text) {
              if (int.parse(text!) < 1 || int.parse(text) > 151) {
                return "Ingrese un ID entre 1 y 152";
              } else {
                return null;
              }
            },
          )),
    );
  }
}
