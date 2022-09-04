import 'dart:convert';
import 'package:delayed_display/delayed_display.dart';
//import 'package:flutter/cupertino.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:home7/screens/question_screen.dart';
import 'package:home7/widget/my_style.dart';

import 'package:http/http.dart' as htt;
//import '../models/question_format.dart';

class CalApi extends StatelessWidget with MyStyle {
  static const String calApi = '/CallApi';

  CalApi({Key? key}) : super(key: key);
  static List? data;
  int index = 1;
  late String s = '';
  bool done = false;

  Future<List> getQuetion() async {
    var question =
        await htt.get(Uri.tryParse('https://opentdb.com/api.php?amount=50')!);
    print(question.statusCode);
    if (question.statusCode == 200) {
      var result = question.body;
      // print(question);
      result = result.toString();
      //print(result);
      Map json = jsonDecode(result);
      // print(json['results'][index]['question']);

      return json['results'];
    } else {
      throw Exception('Error');
    }
  }

  // Future future;
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder<List>(
      future: getQuetion(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasError) {
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:

              break;
            case ConnectionState.done:
              data = snapshot.data;
             // print(data);
              done = true;
              s = data![index]['question'];
              break;
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
        }
        if (done) {
          return Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(bottom: 0.1*hight),
                    child: const Text('Welcome to Quizzler App ',
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                        style: TextStyle(

                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        )),
                  ),
                  const DelayedDisplay(
                    delay: Duration(seconds: 1),
                    child: Text(
                      ' Please Press the Button below To Start the Quizzler',
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top: 0.05*hight),
                    child:  DelayedDisplay(
                      delay: const Duration(seconds: 1),
                      child: BouncingWidget(
                        scaleFactor: 1.5,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(QuestionScreen.questionScreen);
                        },
                        child: Container(
                          height: 0.1*hight,
                          width: 0.4*width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.yellowAccent,
                          ),
                          child: const Center(
                            child: Text(
                              'Start Quizzler',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8185E2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text('Welcome to Quizzler App ', textAlign: TextAlign.center),
                  Text(' Please Press the Button below To Start the Quizzler',
                      textAlign: TextAlign.center),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
