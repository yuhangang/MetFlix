import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:metflix/state/models/movie.dart';
import 'package:metflix/utils/toast_helper.dart';

const popularUrl =
    'http://api.themoviedb.org/3/movie/popular?api_key=9c9576f8c2e86949a3220fcc32ae2fb6';

abstract class MovieServices {
  static Future<List<Movie>> getPopularVideos({int page = 1}) async {
    List<Movie> fetchedMovie = [];
    late Response response;
    if (page == 500) return fetchedMovie;

    try {
      response = await Dio().get(popularUrl + '&page=$page');
    } catch (e) {
      bool isConnected = await isInternet();
      if (!isConnected) ToastHelper.showToast('no internet connection');
      return fetchedMovie;
    }

    try {
      Map<String, dynamic> data = response.data;

      data['results'].forEach((e) {
        try {
          fetchedMovie.add(Movie.fromJson(e));
        } catch (err) {
          debugPrint('Parsing json error : $e');
          debugPrint(err.toString());
        }
      });
    } catch (e) {
      debugPrint('error: $e');
    }
    return fetchedMovie;
  }
}

//abstract class CustomImage {
//  Widget getBackDrop() {}
//}

Future<bool> isInternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network, make sure there is actually a net connection.
    if (await InternetConnectionChecker().hasConnection) {
      // Mobile data detected & internet connection confirmed.
      return true;
    } else {
      // Mobile data detected but no internet connection found.
      return false;
    }
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a WIFI network, make sure there is actually a net connection.
    if (await InternetConnectionChecker().hasConnection) {
      // Wifi detected & internet connection confirmed.
      return true;
    } else {
      // Wifi detected but no internet connection found.
      return false;
    }
  } else {
    // Neither mobile data or WIFI detected, not internet connection found.
    return false;
  }
}
