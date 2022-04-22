import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../ui/ui.dart';
import '../sign_up.dart';
import 'cubit/sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          Navigator.of(context).pop();
          showSuccessNotification(
            context,
            message: 'PIN registration succeded!',
          );
        }
      },
      builder: (_, state) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            const SizedBox(height: 36),
            const Text(
              'Pick a secret PIN to enter the App!',
            ),
            const SizedBox(height: 18),
            Center(
              child: Pinput(
                length: 4,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: context.read<SignUpCubit>().signUpUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
