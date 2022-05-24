import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pokeapp/api/poke_api.dart';
import 'package:pokeapp/helper/http.dart';
import 'package:pokeapp/models/pokemon.dart';
import 'package:pokeapp/pages/widgets/color_poke.dart';
import 'package:pokeapp/pages/widgets/imagen_poke.dart';
import 'package:pokeapp/pages/widgets/pokeform.dart';
import 'package:pokeapp/utils/font_style.dart';
import 'package:pokeapp/utils/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokeApi _pokeApi = GetIt.instance<PokeApi>();
  Pokemon? _pokemon;
  int _count = 0;
  List<Pokemon> pokemons = [];
  int _value = 1;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    debugPrint("inicio");
    _loadPokemons();
    super.initState();
  }

  Future<void> _loadPokemons() async {
    final response = await _pokeApi.getUserInfo();
    if (response.data != null) {
      _pokemon = response.data;
      pokemons.add(_pokemon!);
      setState(() {});
    }
  }

  void _submit(Http httpoke) {
    final isFormOk = _formKey.currentState!.validate();
    if (isFormOk) actuPoke(httpoke, _value);
  }

  @override
  Widget build(BuildContext context) {
    final httpoke = GetIt.instance<Http>();

    final Responsive responsive = Responsive(context);
    final padding = MediaQuery.of(context).padding;

    if (_pokemon == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  color: Colores(pokemons[_count]).color(),
                  height: responsive.height - padding.top,
                  child: Column(
                    children: [
                      SizedBox(height: responsive.hp(5)),
                      Text(
                        pokemons[_count].name,
                        style:
                            MyStyle.title.copyWith(fontSize: responsive.dp(5)),
                      ),
                      PokeImagen(
                          responsive: responsive, pokemon: pokemons[_count]),

                      //FLECHAS
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                              child: const Icon(Icons.arrow_back_ios),
                              onPressed: () async {
                                if (pokemons[_count].id > 1) {
                                  actuPoke(httpoke, pokemons[_count].id - 1);
                                }
                              }),
                          Text(
                            " ${(pokemons[_count].id)} ",
                            style: MyStyle.id,
                          ),
                          ElevatedButton(
                              child: const Icon(Icons.arrow_forward_ios),
                              onPressed: () async {
                                if (pokemons[_count].id < 152) {
                                  actuPoke(httpoke, pokemons[_count].id + 1);
                                }
                              })
                        ],
                      ),
                      PokeForm(pokemon: pokemons[_count]),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              onChanged: (value) {
                                if (value.isNotEmpty) _value = int.parse(value);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (v) => _submit(httpoke),
                              validator: (text) {
                                if (int.parse(text!) < 1 ||
                                    int.parse(text) > 151) {
                                  return "Ingrese un ID entre 1 y 152";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: Text(
                                    "Buscar por ID",
                                    style: TextStyle(
                                        color:
                                            Colores(pokemons[_count]).color()),
                                  ),
                                  suffixIcon: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: Icon(
                                        Icons.search,
                                        size: responsive.wp(7),
                                        color:
                                            Colores(pokemons[_count]).color(),
                                      ),
                                      onPressed: () => _submit(httpoke)),
                                  fillColor: Colors.white,
                                  filled: true),
                              cursorColor: Colores(pokemons[_count]).color(),
                              style: MyStyle.bold,
                            ))
                          ],
                        ),
                      ),
                      randomPokeButtom(responsive, httpoke)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  ElevatedButton randomPokeButtom(Responsive responsive, Http httpoke) {
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
          actuPoke(httpoke, random.nextInt(151) + 1);
        });
  }

  void actuPoke(Http httpoke, int valor) async {
    final int encontrado = buscaPoke(valor);
    if (encontrado == -1) {
      final pokeApi = PokeApi(httpoke, valor);
      final response = await pokeApi.getUserInfo();
      if (response.data != null) {
        _pokemon = response.data;
        pokemons.add(_pokemon!);
        _count = buscaPoke(_pokemon!.id);
      }
    } else {
      _count = encontrado;
    }

    setState(() {});
  }

  ///Devuelde la posicion en la lista del Pokemon, si no existe devuelve -1
  int buscaPoke(int id) {
    int i = 0, position = -1;
    for (var element in pokemons) {
      if (element.id == id) position = i;
      i++;
    }
    return position;
  }
}
