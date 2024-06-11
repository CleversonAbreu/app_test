import '../models/auth_model.dart';
import '../models/result_auth_model.dart';

abstract class AuthDatasource {
  Future<ResultAuthModel> auth(AuthModel authModel);
}
