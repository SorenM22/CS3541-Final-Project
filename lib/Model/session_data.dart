class SessionData {
  static final SessionData _sessionData = SessionData();

  String selectedDatabase = "";
  String searchContent = "";

  factory SessionData() {
    return _sessionData;
  }

  SessionData._internal();
}