import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

/// Obtiene las dimensiones la pantalla
class Responsive {
  late double _with, _height, _diagonal;
  //True si es tablet
  late bool _isTablet;

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _with = size.width;
    _height = size.height;
    _diagonal = math.sqrt(size.width * size.width + size.height * size.height);
    _isTablet = size.shortestSide >= 600;
  }

  ///Devuelve el ancho de la pantalla
  double get width => _with;

  ///Devuelve la altura de la pantalla
  double get height => _height;

  ///Devuelve la diagonal de la pantalla
  double get diagonal => _diagonal;

  ///Devuelve true si es tablet
  bool get isTablet => _isTablet;
  static Responsive of(BuildContext context) => Responsive(context);

  ///Devuelve el ancho de pantalla en porcentaje
  double wp(double percent) => _with * percent / 100;

  ///Devuelve la altura de pantalla en porcentaje
  double hp(double percent) => _height * percent / 100;

  ///Devuelve la diagonal de la pantalla en porcentaje
  double dp(double percent) => _diagonal * percent / 100;
}
