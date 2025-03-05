import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';
import 'package:app_test/modules/settings/presenter/cubit/language_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLanguageDependencies() {
  //  LanguageCubit
  getIt.registerFactory<LanguageCubit>(
      () => LanguageCubit(getIt<SettingsUseCase>()));
}
