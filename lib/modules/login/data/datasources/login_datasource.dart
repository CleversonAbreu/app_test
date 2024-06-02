import 'package:app_test/modules/login/data/models/login_model.dart';
import 'package:app_test/modules/login/data/models/result_login_model.dart';

abstract class LoginDatasource {
  Future<ResultLoginModel> login(LoginModel loginModel);
}
