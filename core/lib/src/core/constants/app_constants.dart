/// Central place for the fixed option sets the UX spec calls for
/// (word-change interval, round duration, BPM). Keeping these as
/// simple const lists avoids any config/abstraction overhead.
class AppConstants {
  AppConstants._();

  static const List<int> wordIntervalSeconds = [3, 5, 10, 15, 20];
  static const int defaultWordIntervalSeconds = 5;

  static const List<int> roundDurationSeconds = [30, 60, 90, 120, 180];
  static const int defaultRoundDurationSeconds = 60;

  /// 0 = "BPM Yok".
  static const List<int> bpmOptions = [
    0,
    70,
    80,
    90,
    100,
    110,
    120,
    130,
    140,
    150,
    160,
  ];
  static const int defaultBpm = 0;

  /// How many recently-used words are remembered to avoid repeats
  /// within a session.
  static const int wordHistorySize = 20;

  static const int countdownFromSeconds = 3;
  static const int lowTimeWarningSeconds = 10;
}
