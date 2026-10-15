/// Word categories, matching the "category" values stored in
/// assets/data/words.json. [random] is a selection mode (pull from every
/// category, balanced) rather than a real bucket of its own words —
/// its json entries are simply generic/uncategorized freestyle words.
enum WordCategory {
  random('random', 'Rastgele'),
  street('street', 'Sokak'),
  daily('daily', 'Günlük Hayat'),
  objects('objects', 'Nesneler'),
  places('places', 'Mekânlar'),
  people('people', 'İnsanlar'),
  emotions('emotions', 'Duygular'),
  nature('nature', 'Doğa'),
  technology('technology', 'Teknoloji'),
  food('food', 'Yemek'),
  money('money', 'Para'),
  transportation('transportation', 'Ulaşım'),
  humor('humor', 'Komik'),
  battle('battle', 'Battle'),
  abstract('abstract', 'Soyut'),
  difficult('difficult', 'Zor Kelimeler');

  const WordCategory(this.jsonKey, this.label);

  final String jsonKey;
  final String label;

  static WordCategory fromJsonKey(String key) {
    return WordCategory.values.firstWhere(
      (c) => c.jsonKey == key,
      orElse: () => WordCategory.random,
    );
  }

  /// Real categories a word can belong to in the JSON data (excludes the
  /// [random] selection mode itself... note: "random" IS also a valid
  /// json category of generic words, so it's included here too).
  static List<WordCategory> get selectable => WordCategory.values;
}
