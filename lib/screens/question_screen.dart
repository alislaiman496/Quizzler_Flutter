import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import 'package:home7/models/question_format.dart';
import 'package:home7/screens/result_screen.dart';
import 'package:home7/services/call_api.dart';
import 'package:home7/widget/my_style.dart';

import '../widget/mu_function_widget.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class QuestionScreen extends StatefulWidget {
  static const String questionScreen = '/QuestionScreen';

  const QuestionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with MyStyle, MyFunction {
  bool finish=false;

  String question = '';
  double countTrue = 0;
  double countFalse = 0;
  List lst = CalApi.data!;
  int index = 0;
  double myScore = 0;
  int? groupValue = 4;
  List answers = [];
  bool shufle = true;
  List<Icon> icn = [];
  bool canselTim=false;
  bool startTim=false;
  int start = 0;
  ScrollController sc = ScrollController();

  QuestionFormat q1 = QuestionFormat(
      question: 'question',
      correctAnswer: 'correctAnswer',
      incorrectAnswers: []);

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int second=10;


    if (shufle) {
      q1 = getquestiontext(lst, index);
      question = q1.question;
      answers = q1.incorrectAnswers;
      answers.add(q1.correctAnswer);
      answers.shuffle();
      shufle = false;

    }
    void onPress(){
      if (groupValue != 4&&!canselTim) {
        if (answers[groupValue as int] != q1.correctAnswer||finish) {
          countFalse++;
          icn.add(const Icon(Icons.cancel));
        } else {
          countTrue++;
          icn.add(const Icon(Icons.check));

        }
        sc.animateTo(sc.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.ease);
        shufle = true;
        if (isfinished(lst, index)) {
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return ClassicGeneralDialogWidget(
                titleText:
                'You are Pass the Exam in the Quizzler',
                contentText:
                ''' press confirm to Show your Score''',
                onPositiveClick: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Results.id);
                },
              );
            },
            animationType: DialogTransitionType.size,
            curve: Curves.fastOutSlowIn,
            duration: const Duration(seconds: 1),
          );
          reset(lst, index);
        } else {
          index++;
        }
      }
      finish=false;
      groupValue=4;
      myScore = (countTrue / lst.length) * 100;
      if ((countFalse / lst.length) * 100 == 40) {
        canselTim=true;
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ClassicGeneralDialogWidget(
              titleText: 'You are Fall in the Quizzler',
              contentText:
              ''' press confirm to return to Start Screen''',
              onPositiveClick: () {
                Navigator.of(context)
                    .pushReplacementNamed(CalApi.calApi);
              },
            );
          },
          animationType: DialogTransitionType.scaleRotate,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
        );
      }
      if (myScore == 60) {
        canselTim=true;
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return ClassicGeneralDialogWidget(
              titleText: 'You are Pass the Quizzler',
              contentText:
              '''if you want to complete the Quizzler Press ok
                                             if you want to re do the Quizzler press cansel''',
              onPositiveClick: () {
                startTim =true;
              },
              onNegativeClick: () {
                Navigator.of(context).pushReplacementNamed(
                    Results.id,
                    arguments: myScore);
              },
            );
          },
          animationType: DialogTransitionType.size,
          curve: Curves.fastOutSlowIn,
          duration: const Duration(seconds: 1),
        );
        startTim=true;
      }
      groupValue = 4;
    }
    var countDown=TimerCountdown(
      format: CountDownTimerFormat.secondsOnly,

      endTime: DateTime.now().add(
        Duration(
          seconds: second,

        ),
      ),
      onEnd: () {
        if(!canselTim){
        setState(() {
            finish=true;
            groupValue=answers.indexOf(q1.correctAnswer);
       //     print(q1.incorrectAnswers[0]);
            onPress();



        }); }
      },
    );
    Column column1;
    var listTile1 = ListTile(
      title: Text(answers[0]),
      leading: Radio(
          value: 0,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value as int?;
              //    debugPrint(groupValue.toString());
            });
          }),
    );
    var listTile2 = ListTile(
      title: Text(answers[1]),
      leading: Radio(
          value: 1,
          groupValue: groupValue,
          onChanged: (value) {
            setState(() {
              groupValue = value as int?;
              //    debugPrint(value.toString());
            });
          }),
    );

    if (answers.length < 3) {
      column1 = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0.05 * hight),
            child: const Text('The Answers is:',
                style: TextStyle(fontSize: 20, color: Colors.teal)),
          ),
          listTile1,
          listTile2,
        ],
      );
    } else {
      var listTile3 = ListTile(
        title: Text(answers[2]),
        leading: Radio(
            value: 2,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value as int?;
                //debugPrint(value.toString());
              });
            }),
      );
      var listTile4 = ListTile(
        title: Text(answers[3]),
        leading: Radio(
            value: 3,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value as int?;
                //debugPrint(value.toString());
              });
            }),
      );
      column1 = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0.05 * hight),
            child: const Text(
              'The Answers is:',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
          ),
          listTile1,
          listTile2,
          listTile3,
          listTile4,
        ],
      );
    }


    return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          title: const Text('Quizzler App'),
          centerTitle: true,
          flexibleSpace: Text(
            'My Score $myScore %',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(0.05 * hight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SelectableText(
                            q1.question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.brown,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        column1,
                        countDown,
                      ],
                    ),
                  )),
                  color: Colors.grey,
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: Divider(
                    color: Colors.green,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {

                     onPress();
                    });
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.indigo, fontSize: 30),
                  ),
                  style: raisedButtonStyle,
                ),
              ),
              Scrollbar(
                controller: sc,
                child: SingleChildScrollView(
                  controller: sc,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.horizontal,
                  padding:
                      EdgeInsets.only(top: 0.01 * hight, bottom: 0.01 * hight),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: icn),
                ),
              ),
            ],
          ),
        ));
  }
}
