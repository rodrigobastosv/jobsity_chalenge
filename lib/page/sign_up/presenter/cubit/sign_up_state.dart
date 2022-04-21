import 'package:equatable/equatable.dart';

enum SignUpStatus {
  initial,
  success,
  failure,
}

class SignUpState extends Equatable {
  final SignUpStatus status;

  const SignUpState({
    required this.status,
  });

  factory SignUpState.initial() => const SignUpState(
        status: SignUpStatus.initial,
      );

  SignUpState copyWith({
    SignUpStatus? status,
  }) {
    return SignUpState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
