import 'package:equatable/equatable.dart';

enum SignInStatus {
  initial,
  success,
  failure,
}

class SignInState extends Equatable {
  final SignInStatus status;

  const SignInState({
    required this.status,
  });

  factory SignInState.initial() => const SignInState(
        status: SignInStatus.initial,
      );

  SignInState copyWith({
    SignInStatus? status,
  }) {
    return SignInState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
