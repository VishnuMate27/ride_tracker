import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_tracker/model/RouteModel.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController{
  List<RouteModel> routeList = [];
  ScrollController scrollController = ScrollController();
  RxBool scrolled = false.obs;
  Future<List<RouteModel>> getRouteApi() async {
    final resposne = await http.get(
        Uri.parse('http://flutter.dev.emotorad.com/get_routes'),
        headers: {'Authorization': 'matevishnu27@gmail.com'});
    var data = jsonDecode(resposne.body.toString());
    if (resposne.statusCode == 200) {
      routeList.clear();
      for (Map<String, dynamic> i in data) {
        routeList.add(RouteModel.fromJson(i));
      }
      return routeList;
    } else {
      return routeList;
    }
  }

  Future postRouteApi(int index,bool bookmark) async {
    final response = await http.post(
      Uri.parse('http://flutter.dev.emotorad.com/bookmark_route'),
      headers: {
        'Authorization': 'matevishnu27@gmail.com',
        'Content-Type':
        'application/json' // Set the content type based on your API requirements
      },
      body: json.encode({
        "route_id": index+1,
        "bookmark": !bookmark
      }),
    );
    if (response.statusCode == 200) {
      print('Updated');

    } else {
      print(response.body);
    }
  }
}

