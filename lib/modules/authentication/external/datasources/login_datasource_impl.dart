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
    final response = await dio.get("path");
    if (response.statusCode == 200) {
      final ResultLoginModel resultLoginModel = response.data;
      return resultLoginModel;
    } else {
      throw DataSourceError();
    }
  }
}
