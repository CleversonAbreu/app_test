import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/modules/authentication/data/datasources/login_datasource.dart';
import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/data/models/result_login_model.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:dio/dio.dart';

class LoginDataSourceImpl implements LoginDatasource {
  final Dio dio;

  LoginDataSourceImpl(this.dio);
  @override
  Future<ResultLoginModel> login(LoginModel loginModel) async {
    try {
      final response = await dio.get('${AppConstants.url_base}/login');
      if (response.statusCode == 200) {
        ResultLoginModel result = ResultLoginModel.fromMap(response.data[0]);
        return result;
      } else {
        throw DataSourceError();
      }
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }
}
