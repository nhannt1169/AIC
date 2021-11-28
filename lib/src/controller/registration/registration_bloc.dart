import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imagecaptioning/src/controller/auth/form_submission_status.dart';

import 'package:imagecaptioning/src/controller/data_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc()
      : _dataRepository = DataRepository(),
        super(const RegistrationState()) {
    on<RegistrationUsernameChanged>(_onUsernameChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationEmailChanged>(_onEmailChanged);
    on<RegistrationSubmitted>(_onSubmitted);
  }

  final DataRepository _dataRepository;

  void _onUsernameChanged(
    RegistrationUsernameChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final username = event.username;

    emit(state.copyWith(
      username: username,
      formStatus: state.validate(username, state.password, state.email),
    ));
  }

  void _onPasswordChanged(
    RegistrationPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final password = event.password;
    emit(state.copyWith(
      password: password,
      formStatus: state.validate(state.username, password, state.email),
    ));
  }

  void _onEmailChanged(
    RegistrationEmailChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final email = event.email;
    emit(state.copyWith(
      email: email,
      formStatus: state.validate(state.username, state.password, email),
    ));
  }

  void _onSubmitted(
    RegistrationSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    if (state.formStatus is FormValidationSuccess) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        await _dataRepository.registerDefault(
            username: state.username,
            password: state.password,
            email: state.email);

        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (_) {
        emit(state.copyWith(formStatus: SubmissionFailed(_)));
      }
    }
  }
}
