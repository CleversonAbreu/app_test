import 'package:app_test/core/constants/app_constants.dart';

import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/auth_datasource.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/result_auth_model.dart';

class AuthDataSourceImpl implements AuthDatasource {
  final Dio dio;

  AuthDataSourceImpl(this.dio);
  @override
  Future<ResultAuthModel> auth(AuthModel authModel) async {
    try {
      final response = await dio.get('${AppConstants.url_base}/login');
      if (response.statusCode == 200) {
        ResultAuthModel result = ResultAuthModel.fromMap(response.data[0]);
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
