import 'dart:math';

import 'package:koala_freestyle_core/koala_freestyle_core.dart';
import 'package:test/test.dart';

List<Word> _sampleWords() {
  return [
    const Word(
      text: 'araba',
      category: WordCategory.transportation,
      difficulty: Difficulty.kolay,
    ),
    const Word(
      text: 'metro',
      category: WordCategory.transportation,
      difficulty: Difficulty.orta,
    ),
    const Word(
      text: 'yağmur',
      category: WordCategory.nature,
      difficulty: Difficulty.kolay,
    ),
    const Word(
      text: 'paradoks',
      category: WordCategory.difficult,
      difficulty: Difficulty.zor,
    ),
    const Word(
      text: 'algoritma',
      category: WordCategory.technology,
      difficulty: Difficulty.zor,
    ),
  ];
}

void main() {
  group('WordGenerator', () {
    test('does not repeat a word until the pool is exhausted', () {
      final generator = WordGenerator(
        allWords: _sampleWords(),
        random: Random(42),
      );
      final seen = <String>[];
      for (var i = 0; i < 5; i++) {
        final w = generator.next();
        expect(w, isNotNull);
        expect(
          seen.contains(w!.text),
          isFalse,
          reason: 'word "${w.text}" repeated before pool exhausted',
        );
        seen.add(w.text);
      }
    });

    test('filters by category', () {
      final generator = WordGenerator(
        allWords: _sampleWords(),
        category: WordCategory.transportation,
        random: Random(1),
      );
      for (var i = 0; i < 10; i++) {
        final w = generator.next();
        expect(w!.category, WordCategory.transportation);
      }
    });

    test('filters by difficulty', () {
      final generator = WordGenerator(
        allWords: _sampleWords(),
        difficulty: Difficulty.zor,
        random: Random(1),
      );
      for (var i = 0; i < 10; i++) {
        final w = generator.next();
        expect(w!.difficulty, Difficulty.zor);
      }
    });

    test('random category pulls from every category', () {
      final generator = WordGenerator(
        allWords: _sampleWords(),
        category: WordCategory.random,
        random: Random(7),
      );
      expect(generator.poolSize, _sampleWords().length);
    });

    test('empty pool does not crash and returns null', () {
      final generator = WordGenerator(allWords: const [], random: Random(1));
      expect(generator.isEmpty, isTrue);
      expect(generator.next(), isNull);
      expect(generator.nextPair(), isNull);
    });

    test('empty pool from an impossible filter combination is safe', () {
      final generator = WordGenerator(
        allWords: _sampleWords(),
        category: WordCategory.food,
        difficulty: Difficulty.manyak,
        random: Random(1),
      );
      expect(generator.isEmpty, isTrue);
      expect(generator.next(), isNull);
    });

    test('nextPair returns two distinct words when possible', () {
      final generator = WordGenerator(
        allWords: _sampleWords(),
        random: Random(3),
      );
      final pair = generator.nextPair();
      expect(pair, isNotNull);
      expect(pair!.length, 2);
      expect(pair[0].text, isNot(pair[1].text));
    });
  });
}
