import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:coh_fair_teams_frontend/model/mvp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:http/http.dart';

import '../model/matchupoption.dart';

class ApiService {

  String endpoint = 'http://localhost:8000/test';

  Future<List<MatchUpOption>> getMatchUpTest() async {
    Dio dio = Dio()
      ..options = BaseOptions(
        connectTimeout: 30000, // Adjust the timeout value as needed (in milliseconds)
        receiveTimeout: 30000, // Adjust the timeout value as needed (in milliseconds)
        // headers: {
        //   "Access-Control-Allow-Origin": "*", // Add the header
        // },
      );

    try {
      Response response = await dio.get(endpoint);

      if (response.statusCode == 200) {
        final List result = response.data;
        // return result.map(((e) => MatchUpOption.fromJson(e))).toList();
        //List<dynamic> jsonData = jsonDecode(result);
        List<MatchUpOption> matchUpOptions = result.map((e) => MatchUpOption.fromJson(e as Map<String, dynamic>)).toList();
        return matchUpOptions;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      // Handle DioError exceptions and other exceptions if needed
      throw Exception(e.toString());
    }
  }


  Future<List<MatchUpOption>> getPlayerData(Map<String, bool> playerData) async {
    Dio dio = Dio()
      ..options = BaseOptions(
        connectTimeout: 30000, // Adjust the timeout value as needed (in milliseconds)
        receiveTimeout: 30000, // Adjust the timeout value as needed (in milliseconds)
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
      );

    // Create a list of player names with value 'true'
    List<String> playerNames = playerData.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Create a new map with the key 'player_names' and value as the list of player names
    Map<String, dynamic> requestData = {"player_names": playerNames};

    String apiUrl = "https://www.volle-power-mc.de:8000";
    if (kReleaseMode) {
        apiUrl = 'https://www.volle-power-mc.de:8000';
    } else if (kDebugMode) {
        apiUrl = 'http://localhost:8000';
    }

    try {
      print(apiUrl);
      Response response = await dio.post(
        "${apiUrl}/get_fairest_matchups/",
        data: jsonEncode(requestData),
      );
      // print(apiUrl);
      // Response response = await dio.get(
      //   "${apiUrl}/test/",
      // );

      if (response.statusCode == 200) {
        final List result = response.data;
        List<MatchUpOption> matchUpOptions =
        result.map((e) => MatchUpOption.fromJson(e as Map<String, dynamic>)).toList();
        return matchUpOptions;
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      // Handle DioError exceptions and other exceptions if needed
      throw Exception(e.toString());
    }
  }


  Future<MVPData> mvpPerMode() async {
    Dio dio = Dio()
      ..options = BaseOptions(
        connectTimeout: 30000, // Adjust the timeout value as needed (in milliseconds)
        receiveTimeout: 30000, // Adjust the timeout value as needed (in milliseconds)
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
      );



    String apiUrl = "https://www.volle-power-mc.de:8000";
    if (kReleaseMode) {
      apiUrl = 'https://www.volle-power-mc.de:8000';
    } else if (kDebugMode) {
      apiUrl = 'http://localhost:8000';
    }

    try {

      Response response = await dio.get(
        "${apiUrl}/mvp_per_mode/",
      );

      if (response.statusCode == 200) {
        return MVPData.fromJson(jsonDecode(jsonEncode(response.data)));
      } else {
        throw Exception('Failed to load MVP data');
      }
    }
     catch (e) {
      // Handle DioError exceptions and other exceptions if needed
      throw Exception(e.toString());
    }
  }




}

//API SERVICE Provider
final apiProvider = Provider<ApiService>((ref) => ApiService());