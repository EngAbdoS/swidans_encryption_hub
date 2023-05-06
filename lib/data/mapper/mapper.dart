import 'package:flu_proj/app/constants.dart';
import 'package:flu_proj/app/extensions.dart';
import 'package:flu_proj/data/response/responses.dart';
import 'package:flu_proj/domain/models/models.dart';




extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

