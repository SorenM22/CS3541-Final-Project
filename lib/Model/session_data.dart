enum SearchContent {
  listings,
  trends;
}

class SessionData {
  static SessionData? _instance;

  SessionData._();

  factory SessionData() => _instance ??= SessionData._();

  String selectedDatabase = "";
  SearchContent searchContent = SearchContent.listings;
}