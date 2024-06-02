import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/data/models/result_login_model.dart';

abstract class LoginDatasource {
  Future<ResultLoginModel> login(LoginModel loginModel);
}
