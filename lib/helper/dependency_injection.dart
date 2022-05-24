import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokeapp/api/poke_api.dart';
import 'package:pokeapp/helper/http.dart';

abstract class DependencyInjection {
  static void inicialize() {
//***************POKEAPI**************** */
    final Dio pokedio = Dio(BaseOptions(baseUrl: "https://pokeapi.co/api"));
    Http httpoke = Http(
      dio: pokedio,
      logsEnabled: false, //HABILITAR LOGS
    );
    final pokeApi = PokeApi(httpoke, 1);
//***************POKEAPI**************** */

    GetIt.instance.registerSingleton<PokeApi>(pokeApi);
    GetIt.instance.registerSingleton<Http>(httpoke);
  }
}
