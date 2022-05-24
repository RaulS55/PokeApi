import 'package:pokeapp/helper/http.dart';
import 'package:pokeapp/helper/http_response.dart';
import 'package:pokeapp/models/pokemon.dart';

class PokeApi {
  final Http http;
  final int numero;
  PokeApi(this.http, this.numero);

  Future<HttpResponse<Pokemon>> getUserInfo() async {
    return http.request<Pokemon>(
      "/v2/pokemon/$numero/",
      method: "GET",
      parser: (data) {
        return Pokemon.fromJson(data);
      },
    );
  }
}
