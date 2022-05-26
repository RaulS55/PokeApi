import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:pokeapp/api/poke_api.dart';
import 'package:pokeapp/helper/http.dart';
import 'package:pokeapp/models/pokemon.dart';

class HomeController extends ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _count = 0;
  final PokeApi _pokeApi = GetIt.instance<PokeApi>();
  Pokemon? _pokemon;
  final List<Pokemon> _pokemons = [];

  final httpoke = GetIt.instance<Http>();

  GlobalKey<FormState> get formKey => _formKey;
  int get count => _count;
  List<Pokemon> get pokemons => _pokemons;
  Pokemon get selectPoke => pokemons[count];

  HomeController() {
    _loadPokemons();
  }

  void countChange(int count) {
    _count = count;
  }

  void countIncrement() {
    _count++;
    notifyListeners();
  }

  Future<void> _loadPokemons() async {
    final response = await _pokeApi.getUserInfo();
    if (response.data != null) {
      _pokemon = response.data;
      pokemons.add(_pokemon!);
      notifyListeners();
    }
  }

  ///Cambia el pokemon, llama a la API si el pokemon no fue guardado antes
  void actuPoke(int valor) async {
    final int encontrado = buscaPoke(valor);
    if (encontrado == -1) {
      final pokeApi = PokeApi(httpoke, valor);
      final response = await pokeApi.getUserInfo();
      if (response.data != null) {
        _pokemon = response.data;
        pokemons.add(_pokemon!);
        countChange(buscaPoke(_pokemon!.id));
      }
    } else {
      countChange(encontrado);
    }
    notifyListeners();
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
