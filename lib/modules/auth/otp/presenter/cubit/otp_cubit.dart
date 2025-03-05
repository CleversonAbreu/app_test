// ignore: depend_on_referenced_packages
import 'package:app_test/modules/auth/otp/errors/otp_error.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../../otp/domain/usecases/send_otp_usecase.dart';
import '../../../otp/domain/usecases/verify_otp_usecase.dart';

part 'otp_state.dart';

class OTPCubit extends Cubit<OTPState> {
  final SendOTP sendOTP;
  final VerifyOTP verifyOTP;
  bool _isClosed = false;

  OTPCubit({
    required this.sendOTP,
    required this.verifyOTP,
  }) : super(OTPInitialState());

  @override
  Future<void> close() async {
    _isClosed = true;
    await super.close();
  }

  Future<void> _guardedEmit(OTPState state) async {
    if (!_isClosed) {
      emit(state);
    }
  }

  Future<void> sendOTPCode(String email, String typeGenerate) async {
      _guardedEmit(OTPLoadingState());
    try {
      await sendOTP(email,typeGenerate);
      _guardedEmit(OTPSentState());
    } on OTPError catch (error) {
      _guardedEmit(OTPErrorState(error.type));
    } catch (error) {
      _guardedEmit(OTPErrorState(OTPErrorType.unknownError));
    }
  }

  Future<void> verifyOTPCode(String email,String otp) async {
    _guardedEmit(OTPLoadingState());
    try {
      final result = await verifyOTP(email,otp);
      if (result) {
        _guardedEmit(OTPVerifiedState());
      } else {
        _guardedEmit(OTPCodeErrorState());
      }
    } on OTPError catch (error) {
      _guardedEmit(OTPErrorState(error.errorType));
    } catch (error) {
      _guardedEmit(OTPErrorState(OTPErrorType.unknownError));
    }
  }

  Future<void> resendOTPCode(String email, String typeGenerate) async {
    _guardedEmit(OTPLoadingState());
    try {
      await sendOTP(email,typeGenerate);
      _guardedEmit(OTPSentState());
    } on OTPError catch (error) {
      _guardedEmit(OTPErrorState(error.errorType));
    } catch (error) {
      _guardedEmit(OTPErrorState(OTPErrorType.unknownError));
    }
  }
}
