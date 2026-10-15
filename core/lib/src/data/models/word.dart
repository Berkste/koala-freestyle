import 'difficulty.dart';
import 'word_category.dart';

class Word {
  const Word({
    required this.text,
    required this.category,
    required this.difficulty,
  });

  final String text;
  final WordCategory category;
  final Difficulty difficulty;

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      text: json['word'] as String,
      category: WordCategory.fromJsonKey(json['category'] as String),
      difficulty: Difficulty.fromLevel(json['difficulty'] as int),
    );
  }

  @override
  String toString() => text;

  @override
  bool operator ==(Object other) => other is Word && other.text == text;

  @override
  int get hashCode => text.hashCode;
}
