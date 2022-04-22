import 'package:equatable/equatable.dart';

enum SignInStatus {
  initial,
  success,
  failure,
  loading,
}

class SignInState extends Equatable {
  final String pin;
  final SignInStatus status;
  final bool? canCheckBiometrics;

  const SignInState({
    required this.pin,
    required this.status,
    required this.canCheckBiometrics,
  });

  factory SignInState.initial() => const SignInState(
        pin: '',
        status: SignInStatus.initial,
        canCheckBiometrics: null,
      );

  SignInState copyWith({
    String? pin,
    SignInStatus? status,
    bool? canCheckBiometrics,
  }) {
    return SignInState(
      pin: pin ?? this.pin,
      status: status ?? this.status,
      canCheckBiometrics: canCheckBiometrics ?? this.canCheckBiometrics,
    );
  }

  @override
  List<Object?> get props => [
        pin,
        status,
        canCheckBiometrics,
      ];
}
