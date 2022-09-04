import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:home7/screens/question_screen.dart';
import 'package:home7/services/call_api.dart';

class Results extends StatelessWidget {
  late double score;
   Results({Key? key,required this.score}) : super(key: key);
    static const String id='/Results';
  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return   Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:  EdgeInsets.only(bottom: 0.1*hight),
              child: const Text('Your Score is ',
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  style: TextStyle(

                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
            ),
             DelayedDisplay(
              delay: const Duration(seconds: 1),
              child: Text(
                '$score %',
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: const TextStyle(
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
                        .pushReplacementNamed(CalApi.calApi);
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
                        'ReStart Quizzler',
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
  }
}
