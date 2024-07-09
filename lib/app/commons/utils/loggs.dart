import '../infra/models/log_entry.dart';

mixin Logs {
  Future<void> log(LogEntry log) async {
    print(log);
  }
}
