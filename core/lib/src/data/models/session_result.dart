import 'session_settings.dart';
import 'word.dart';

/// Snapshot of a completed freestyle round, used to render the result
/// screen and to feed the statistics repository.
class SessionResult {
  const SessionResult({
    required this.settings,
    required this.elapsedSeconds,
    required this.wordsUsed,
    required this.completedAt,
  });

  final SessionSettings settings;
  final int elapsedSeconds;
  final List<Word> wordsUsed;
  final DateTime completedAt;

  int get wordCount => wordsUsed.length;
}
