import 'package:melo_ui/melo_ui.dart';

class ResponseModel<T> {
  final bool ok;
  final T? result;
  final String description;
  final String? technicalDescription;
  final int statusCode;
  final String? code;
  final List<MeloUIHttpErrorFieldModel> errors;

  ResponseModel(
      {required this.ok,
      this.result,
      this.description = '',
      required this.statusCode,
      this.code = "",
      List<MeloUIHttpErrorFieldModel>? errors,
      this.technicalDescription})
      : errors = errors ?? [];
}
