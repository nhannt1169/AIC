import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagecaptioning/src/controller/auth/form_submission_status.dart';
import 'package:imagecaptioning/src/controller/data_repository.dart';
import 'package:imagecaptioning/src/controller/registration/registration_bloc.dart';

class RegistrationPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegistrationPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          child: BlocProvider(
            create: (context) {
              return RegistrationBloc();
            },
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _RegistrationButton(),
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('registrationForm_usernameInput_textField'),
          onChanged: (username) => context
              .read<RegistrationBloc>()
              .add(RegistrationUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText: state.usernameIsValid ? null : 'invalid username',
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('registrationForm_passwordInput_textField'),
          onChanged: (password) => context
              .read<RegistrationBloc>()
              .add(RegistrationPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.passwordIsValid ? null : 'invalid password',
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('registrationForm_emailInput_textField'),
          onChanged: (email) => context
              .read<RegistrationBloc>()
              .add(RegistrationEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.emailIsValid ? null : 'invalid email',
          ),
        );
      },
    );
  }
}

class _RegistrationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('RegistrationForm_continue_raisedButton'),
                child: const Text('Registration'),
                onPressed: state.formStatus is FormValidationSuccess
                    ? () {
                        context
                            .read<RegistrationBloc>()
                            .add(const RegistrationSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
