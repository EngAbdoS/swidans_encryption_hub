import 'package:flu_proj/app/app_prefs.dart';
import 'package:flu_proj/data/data_source/local_data_source.dart';
import 'package:flu_proj/data/network/network_info.dart';
import 'package:flu_proj/data/repository/repository_imp.dart';
import 'package:flu_proj/domain/repository/repository.dart';
import 'package:flu_proj/domain/usecase/loginUseCase.dart';
import 'package:flu_proj/domain/usecase/registerUseCase.dart';
import 'package:flu_proj/presentation/forgot_password/viewModel/forgotPasswordViewModel.dart';
import 'package:flu_proj/presentation/login/viewModel/login_viewModel.dart';
import 'package:flu_proj/presentation/main/main/viewModel/main_viewModel.dart';
import 'package:flu_proj/presentation/register/registerViewModel/registerViewModel.dart';
import 'package:flu_proj/presentation/verification/viewModel/verification_viewModel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/remote_data_source.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(InternetConnectionChecker()));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceIml());
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  instance.registerLazySingleton<Repository>(
      () => RepositoryImp(instance(), instance(), ));
}

initHomeModule() {
  if (!GetIt.I.isRegistered<MainViewModel>()) {
    instance.registerFactory<MainViewModel>(() => MainViewModel());

  }
}


initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordViewModel>()) {

    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel());
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}


initVerificationModule() {
  if (!GetIt.I.isRegistered<VerificationViewModel>()) {
    instance
        .registerFactory<VerificationViewModel>(() => VerificationViewModel());
  }
}
