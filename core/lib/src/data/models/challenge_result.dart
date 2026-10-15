import 'word.dart';

class ChallengeResult {
  const ChallengeResult({
    required this.words,
    required this.usedWords,
    required this.durationSeconds,
    required this.elapsedSeconds,
  });

  final List<Word> words;
  final Set<Word> usedWords;
  final int durationSeconds;
  final int elapsedSeconds;

  int get usedCount => usedWords.length;
  int get totalCount => words.length;
  bool get success => usedCount == totalCount;
}
