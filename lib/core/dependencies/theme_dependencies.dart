import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupThemeDependencies() {
  //   ThemeCubit
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<SettingsUseCase>()));
}
