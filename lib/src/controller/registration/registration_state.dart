part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.formStatus = const InitialFormStatus(),
    this.username = "",
    this.password = "",
    this.email = "",
  });

  final FormSubmissionStatus formStatus;
  final String username;
  final String password;
  final String email;
  bool get usernameIsValid => username.length > 6;
  bool get passwordIsValid => password.length > 6;
  bool get emailIsValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);

  RegistrationState copyWith(
      {FormSubmissionStatus? formStatus,
      String? username,
      String? password,
      String? email}) {
    return RegistrationState(
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email);
  }

  @override
  List<Object> get props => [formStatus, username, password, email];

  FormSubmissionStatus validate(
      String username, String password, String email) {
    if (usernameIsValid && passwordIsValid && emailIsValid) {
      return FormValidationSuccess();
    } else {
      return FormValidationFailed();
    }
  }
}
