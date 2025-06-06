class QuestionsModel {
  final String question;
  final List<String> answerBlocks;
  final String correctAnswer;

  QuestionsModel({
    required this.question,
    required this.answerBlocks,
    required this.correctAnswer,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      question: json['question'] as String,
      answerBlocks: List<String>.from(json['answer_blocks'] ?? []),
      correctAnswer: json['correct_answer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer_blocks': answerBlocks,
      'correct_answer': correctAnswer,
    };
  }
}