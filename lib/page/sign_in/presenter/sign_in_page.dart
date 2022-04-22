import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_chalenge/core/core.dart';
import 'package:jobsity_chalenge/page/sign_in/presenter/presenter.dart';
import 'package:pinput/pinput.dart';

import '../../../ui/ui.dart';
import 'cubit/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status == SignInStatus.success) {
          Navigator.of(context).pushNamed(homePage);
        } else if (state.status == SignInStatus.failure) {
          showErrorNotification(
            context,
            title: 'Incorrect PIN',
            message: 'Make sure to put your PIN',
          );
        }
      },
      builder: (_, state) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Enter your PIN to enter the App!',
            ),
            const SizedBox(height: 18),
            Center(
              child: Pinput(
                length: 4,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: context.read<SignInCubit>().signInUser,
              ),
            ),
            const SizedBox(height: 18),
            if (state.status == SignInStatus.loading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
              state.canCheckBiometrics ?? false
                  ? ElevatedButton.icon(
                      onPressed: () =>
                          context.read<SignInCubit>().authWithFingeprint(),
                      icon: const Icon(Icons.fingerprint),
                      label: const Text('SignIn with Fingerprint'),
                    )
                  : const SizedBox.shrink(),
            const SizedBox(height: 18),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Don\'t have a PIN? '),
                  TextSpan(
                    text: 'Register!',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => Navigator.of(context).pushNamed(signUpPage),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
