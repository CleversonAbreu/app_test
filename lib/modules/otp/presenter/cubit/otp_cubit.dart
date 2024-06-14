// ignore: depend_on_referenced_packages
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
  }) : super(OTPInitial());

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

  Future<void> sendOTPCode(String email) async {
    _guardedEmit(OTPLoading());
    try {
      await sendOTP(email);
      _guardedEmit(OTPSent());
    } catch (error) {
      _guardedEmit(OTPError(error.toString()));
    }
  }

  Future<void> verifyOTPCode(String otp) async {
    _guardedEmit(OTPLoading());
    try {
      final result = await verifyOTP(otp);
      if (result) {
        _guardedEmit(OTPVerified());
      } else {
        _guardedEmit(OTPCodeError());
      }
    } catch (error) {
      _guardedEmit(OTPError(error.toString()));
    }
  }

  Future<void> resendOTPCode(String email) async {
    _guardedEmit(OTPLoading());
    try {
      await sendOTP(email);
      _guardedEmit(OTPSent());
    } catch (error) {
      _guardedEmit(OTPError(error.toString()));
    }
  }
}
