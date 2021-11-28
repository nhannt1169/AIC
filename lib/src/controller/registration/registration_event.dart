part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationUsernameChanged extends RegistrationEvent {
  const RegistrationUsernameChanged(this.username);

  final String username;
}

class RegistrationPasswordChanged extends RegistrationEvent {
  const RegistrationPasswordChanged(this.password);

  final String password;
}

class RegistrationEmailChanged extends RegistrationEvent {
  const RegistrationEmailChanged(this.email);

  final String email;
}

class RegistrationSubmitted extends RegistrationEvent {
  const RegistrationSubmitted();
}
