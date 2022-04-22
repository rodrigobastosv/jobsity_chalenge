import 'package:equatable/equatable.dart';

enum SignInStatus {
  initial,
  success,
  failure,
  loading,
}

class SignInState extends Equatable {
  final SignInStatus status;
  final bool? canCheckBiometrics;

  const SignInState({
    required this.status,
    required this.canCheckBiometrics,
  });

  factory SignInState.initial() => const SignInState(
        status: SignInStatus.initial,
        canCheckBiometrics: null,
      );

  SignInState copyWith({
    SignInStatus? status,
    bool? canCheckBiometrics,
  }) {
    return SignInState(
      status: status ?? this.status,
      canCheckBiometrics: canCheckBiometrics ?? this.canCheckBiometrics,
    );
  }

  @override
  List<Object?> get props => [
        status,
        canCheckBiometrics,
      ];
}
