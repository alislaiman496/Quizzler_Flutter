import 'package:flutter/material.dart';
import 'package:home7/screens/question_screen.dart';
import 'package:home7/screens/result_screen.dart';
import 'package:home7/services/call_api.dart';

class RouteGenerator {
  static const String calApi=CalApi.calApi;
  static const String screenQuestion=QuestionScreen.questionScreen;
  static const String screenResults=Results.id;
  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case screenQuestion:

        return MaterialPageRoute(

          builder: (_) =>  const QuestionScreen( ),

        );
      case calApi:

        return MaterialPageRoute(

          builder: (_) =>  CalApi(),

        );
      case screenResults:

        return MaterialPageRoute(

          builder: (_) =>   Results(score: settings.arguments as double),

        );


      default:
        throw const FormatException("Route not found");

    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
