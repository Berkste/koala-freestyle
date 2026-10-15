import 'dart:math';

import '../models/difficulty.dart';
import '../models/word.dart';
import '../models/word_category.dart';

/// Picks words from a filtered pool while avoiding recent repeats.
///
/// Keeps a rolling history (capped at [historySize]) so the same word
/// won't reappear too soon within a session. If the filtered pool is
/// too small to satisfy that (e.g. a narrow category+difficulty
/// combination), it falls back to only excluding the single most
/// recent word so the generator never stalls. If the pool is empty
/// altogether, [next] returns null instead of throwing — callers must
/// handle that rather than assuming a word is always available.
class WordGenerator {
  WordGenerator({
    required List<Word> allWords,
    WordCategory category = WordCategory.random,
    Difficulty? difficulty,
    this.historySize = 20,
    Random? random,
  }) : _random = random ?? Random(),
       _pool = _filterPool(allWords, category, difficulty);

  final int historySize;
  final Random _random;
  final List<Word> _pool;
  final List<Word> _history = [];

  static List<Word> _filterPool(
    List<Word> allWords,
    WordCategory category,
    Difficulty? difficulty,
  ) {
    return allWords
        .where((w) {
          final matchesCategory =
              category == WordCategory.random || w.category == category;
          final matchesDifficulty =
              difficulty == null || w.difficulty == difficulty;
          return matchesCategory && matchesDifficulty;
        })
        .toList(growable: false);
  }

  bool get isEmpty => _pool.isEmpty;
  int get poolSize => _pool.length;

  Word? next() {
    if (_pool.isEmpty) return null;

    var candidates = _pool.where((w) => !_history.contains(w)).toList();
    if (candidates.isEmpty) {
      final last = _history.isEmpty ? null : _history.last;
      candidates = _pool.where((w) => w != last).toList();
      if (candidates.isEmpty) candidates = _pool;
    }

    final word = candidates[_random.nextInt(candidates.length)];
    _pushHistory(word);
    return word;
  }

  /// Two distinct words for the "İkili Challenge" word-combo mode.
  List<Word>? nextPair() {
    final first = next();
    if (first == null) return null;
    if (_pool.length < 2) return [first, first];
    final second = next();
    if (second == null) return [first, first];
    return [first, second];
  }

  void _pushHistory(Word word) {
    _history.add(word);
    while (_history.length > historySize) {
      _history.removeAt(0);
    }
  }

  void reset() => _history.clear();
}
