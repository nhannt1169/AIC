part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.formStatus = const InitialFormStatus(),
    this.username = "",
    this.password = "",
  });

  final FormSubmissionStatus formStatus;
  final String username;
  final String password;

  LoginState copyWith({
    FormSubmissionStatus? formStatus,
    String? username,
    String? password,
  }) {
    return LoginState(
      formStatus: formStatus ?? this.formStatus,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [formStatus, username, password];

  FormSubmissionStatus validate(String username, String password) {
    if (username.isNotEmpty && password.isNotEmpty) {
      return FormValidationSuccess();
    } else {
      return FormValidationFailed();
    }
  }
}
