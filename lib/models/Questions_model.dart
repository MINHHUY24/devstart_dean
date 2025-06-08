class QuestionsModel {
  final String question;
  final List<String> answerBlocks;
  final String correctAnswer;
  final String type;

  QuestionsModel({
    required this.question,
    required this.answerBlocks,
    required this.correctAnswer,
    required this.type,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    final rawQuestion = json['question'] as String;
    final cleanQuestion = rawQuestion.replaceAll('!empty', '').trim();

    return QuestionsModel(
      question: cleanQuestion,
      answerBlocks: List<String>.from(json['answer_blocks'] ?? []),
      correctAnswer: json['correct_answer'] as String,
      type: json['type'] as String? ?? 'multiple_choice',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer_blocks': answerBlocks,
      'correct_answer': correctAnswer,
      'type': type,
    };
  }
}
