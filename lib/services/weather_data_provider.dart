import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newtok_tech_task/confidential/apiKey.dart';
import 'package:newtok_tech_task/constants/api_endpoints.dart';
import 'package:newtok_tech_task/models/weather_data_model/weather_data_model.dart';
import 'package:http/http.dart' as http;

class WeatherDataModelProvider extends ChangeNotifier {
  List<String> weatherList = [];
  WeatherDataModel? _weatherData;
  WeatherDataModel? get weatherData => _weatherData;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = '';
  String get error => _error;
  Future<void> fetchWeather(String cityname) async {
    _isLoading = true;
    _error = "";
    try {
      final searchUrl = "${baseUrl}q=${cityname}&units=metric&appid=$apiKey";
      final responce = await http.get(Uri.parse(searchUrl));
      log(searchUrl);
      log(responce.statusCode.toString());
      log(responce.body);
      if (responce.statusCode == 200 || responce.statusCode == 201) {
        log(responce.body);
        _weatherData = WeatherDataModel.fromJson(jsonDecode(responce.body));
        weatherList.add(_weatherData!.main!.temp.toString());
        notifyListeners();
      } else {
        _error = "Server Error....!";
      }
    } catch (e) {
      log(e.toString(), name: "client");
      _error = "Client Side Error....!!!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
