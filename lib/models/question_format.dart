class QuestionFormat{
 late int index;
  late String question;
  late String correctAnswer;
  late List  incorrectAnswers;

  QuestionFormat({required this.question, required this.correctAnswer, required this.incorrectAnswers});


 @override
  String toString() {
    return 'QuestionFormat{ question: $question, correctAnswer: $correctAnswer, incorrectAnswers: $incorrectAnswers}';
 }

  factory QuestionFormat.fromList(List<dynamic> lst, index) {
    return QuestionFormat(
      question: lst[index]['question'] as String,
      correctAnswer: lst[index]['correct_answer'] as String,
      incorrectAnswers: lst[index]['incorrect_answers'] as List,
    );
  }
}