import 'package:flutter/material.dart';
import 'package:home7/services/call_api.dart';

import '../models/question_format.dart';

class MyFunction {



  void checknextquestion(List lst, int index) {
   // lst = CalApi.data!;
    if (index < lst.length - 1) {
      index++;

      // print(_questionno);
      // print(_quesbank.length);
    }
  }

  QuestionFormat getquestiontext(List lst, int index) {
   // lst = CalApi.data!; //for fetching right question
    return QuestionFormat.fromList(lst, index);
  }

  bool isfinished(List lst, int index) {
    //tocheck and reset the ques set for the app
  //  lst = CalApi.data!;
    if (index >= lst.length - 1) {
      return true;
    } else {
      return false;
    }
  }


  void reset(List lst, int index) {
   // lst = CalApi.data!;
    index = 0;
    lst.shuffle();
  }
  void getNextQuestion(List lst, int index){
    if(isfinished(lst,index)){
      reset(lst, index);
    }
    else{
      index++;
    }
  }
}
