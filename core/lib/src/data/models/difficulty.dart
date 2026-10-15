enum Difficulty {
  kolay(1, 'Kolay'),
  orta(2, 'Orta'),
  zor(3, 'Zor'),
  manyak(4, 'Manyak');

  const Difficulty(this.level, this.label);

  final int level;
  final String label;

  static Difficulty fromLevel(int level) {
    return Difficulty.values.firstWhere(
      (d) => d.level == level,
      orElse: () => Difficulty.kolay,
    );
  }
}
