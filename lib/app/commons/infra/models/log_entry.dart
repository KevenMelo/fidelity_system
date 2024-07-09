class LogEntry {
  final DateTime timestamp;
  final String errorMessage;
  final String event;
  final String token;

  LogEntry(
      {required this.timestamp,
      required this.errorMessage,
      required this.event,
      required this.token});
}
