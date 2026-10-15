/// Aggregate, locally-persisted lifetime + daily stats shown on the
/// home screen and used to drive the streak counter.
class UserStatistics {
  const UserStatistics({
    this.totalRounds = 0,
    this.totalFreestyleSeconds = 0,
    this.totalWordsUsed = 0,
    this.totalChallenges = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastTrainingDate,
    this.todaySeconds = 0,
  });

  final int totalRounds;
  final int totalFreestyleSeconds;
  final int totalWordsUsed;
  final int totalChallenges;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastTrainingDate;

  /// Seconds trained on [lastTrainingDate], only meaningful when that
  /// date is today (the repository resets it once the day rolls over).
  final int todaySeconds;

  UserStatistics copyWith({
    int? totalRounds,
    int? totalFreestyleSeconds,
    int? totalWordsUsed,
    int? totalChallenges,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastTrainingDate,
    int? todaySeconds,
  }) {
    return UserStatistics(
      totalRounds: totalRounds ?? this.totalRounds,
      totalFreestyleSeconds:
          totalFreestyleSeconds ?? this.totalFreestyleSeconds,
      totalWordsUsed: totalWordsUsed ?? this.totalWordsUsed,
      totalChallenges: totalChallenges ?? this.totalChallenges,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastTrainingDate: lastTrainingDate ?? this.lastTrainingDate,
      todaySeconds: todaySeconds ?? this.todaySeconds,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalRounds': totalRounds,
    'totalFreestyleSeconds': totalFreestyleSeconds,
    'totalWordsUsed': totalWordsUsed,
    'totalChallenges': totalChallenges,
    'currentStreak': currentStreak,
    'longestStreak': longestStreak,
    'lastTrainingDate': lastTrainingDate?.toIso8601String(),
    'todaySeconds': todaySeconds,
  };

  factory UserStatistics.fromJson(Map<String, dynamic> json) {
    return UserStatistics(
      totalRounds: json['totalRounds'] as int? ?? 0,
      totalFreestyleSeconds: json['totalFreestyleSeconds'] as int? ?? 0,
      totalWordsUsed: json['totalWordsUsed'] as int? ?? 0,
      totalChallenges: json['totalChallenges'] as int? ?? 0,
      currentStreak: json['currentStreak'] as int? ?? 0,
      longestStreak: json['longestStreak'] as int? ?? 0,
      lastTrainingDate: json['lastTrainingDate'] == null
          ? null
          : DateTime.tryParse(json['lastTrainingDate'] as String),
      todaySeconds: json['todaySeconds'] as int? ?? 0,
    );
  }
}
