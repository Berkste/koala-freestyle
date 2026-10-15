import '../../core/constants/app_constants.dart';
import 'difficulty.dart';
import 'word_category.dart';
import 'word_mode.dart';

/// User-chosen configuration for a freestyle round. Built once in the
/// setup screen (or restored from remembered preferences) and handed
/// to the [FreestyleEngine] as an immutable value.
class SessionSettings {
  const SessionSettings({
    this.category = WordCategory.random,
    this.difficulty,
    this.wordIntervalSeconds = AppConstants.defaultWordIntervalSeconds,
    this.roundDurationSeconds = AppConstants.defaultRoundDurationSeconds,
    this.bpm = AppConstants.defaultBpm,
    this.wordMode = WordMode.single,
  });

  final WordCategory category;

  /// Null means "all difficulties" (no filter).
  final Difficulty? difficulty;
  final int wordIntervalSeconds;
  final int roundDurationSeconds;
  final int bpm;
  final WordMode wordMode;

  bool get hasBpm => bpm > 0;

  SessionSettings copyWith({
    WordCategory? category,
    Difficulty? difficulty,
    bool clearDifficulty = false,
    int? wordIntervalSeconds,
    int? roundDurationSeconds,
    int? bpm,
    WordMode? wordMode,
  }) {
    return SessionSettings(
      category: category ?? this.category,
      difficulty: clearDifficulty ? null : (difficulty ?? this.difficulty),
      wordIntervalSeconds: wordIntervalSeconds ?? this.wordIntervalSeconds,
      roundDurationSeconds: roundDurationSeconds ?? this.roundDurationSeconds,
      bpm: bpm ?? this.bpm,
      wordMode: wordMode ?? this.wordMode,
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category.jsonKey,
    'difficulty': difficulty?.level,
    'wordIntervalSeconds': wordIntervalSeconds,
    'roundDurationSeconds': roundDurationSeconds,
    'bpm': bpm,
    'wordMode': wordMode.name,
  };

  factory SessionSettings.fromJson(Map<String, dynamic> json) {
    return SessionSettings(
      category: WordCategory.fromJsonKey(
        json['category'] as String? ?? 'random',
      ),
      difficulty: json['difficulty'] == null
          ? null
          : Difficulty.fromLevel(json['difficulty'] as int),
      wordIntervalSeconds:
          json['wordIntervalSeconds'] as int? ??
          AppConstants.defaultWordIntervalSeconds,
      roundDurationSeconds:
          json['roundDurationSeconds'] as int? ??
          AppConstants.defaultRoundDurationSeconds,
      bpm: json['bpm'] as int? ?? AppConstants.defaultBpm,
      wordMode: WordMode.values.firstWhere(
        (m) => m.name == json['wordMode'],
        orElse: () => WordMode.single,
      ),
    );
  }
}
