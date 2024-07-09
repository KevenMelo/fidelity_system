import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static String formatPhone(String value) {
    return UtilBrasilFields.obterTelefone(value);
  }

  static String formatCNPJ(String value) {
    return UtilBrasilFields.obterCnpj(value);
  }

  static String removeCaracteres(String value) {
    return UtilBrasilFields.removeCaracteres(value);
  }

  static bool isValidCNPJ(String value) {
    return UtilBrasilFields.isCNPJValido(value);
  }

  static bool isValidPhone(String value) {
    return value.length == 11;
  }

  static Future<bool> saveLocal(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  static Future<String?> getLocal(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static double getCurrencyValueInDouble(String value) {
    return UtilBrasilFields.converterMoedaParaDouble(value);
  }

  static TimeOfDay? getTimeByString(String value) {
    if (value.isEmpty) return null;
    var hour = int.parse(value.split(":").first);
    var minute = int.parse(value.split(":")[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }
}
