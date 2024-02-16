class Question {
  final String type;
  final String difficulty;
  final String category;
  String question; // Change type to String
  final String correct_answer;
  final List<String> incorreect_answers;

  Question({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correct_answer,
    required this.incorreect_answers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      difficulty: json['difficulty'],
      category: json['category'],
      question: _decodeHtmlEntity(json['question']),
      correct_answer: json['correct_answer'],
      incorreect_answers: List<String>.from(json['incorrect_answers']),
    );
  }

  // Function to decode HTML special chars etc. to normal text
  static String _decodeHtmlEntity(String htmlString) {
    var text = htmlString;
    text = text.replaceAll('&quot;', '"');
    text = text.replaceAll("&deg;", "\u2109");
    text = text.replaceAll("&#039;", "`");
    text = text.replaceAll("#039;", "`");
    return text;
  }
}



