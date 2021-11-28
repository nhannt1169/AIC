import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:imagecaptioning/src/controller/auth/form_submission_status.dart';

import 'package:imagecaptioning/src/controller/data_repository.dart';
import 'package:imagecaptioning/src/model/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : _dataRepository = DataRepository(),
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final DataRepository _dataRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = event.username;

    emit(state.copyWith(
      username: username,
      formStatus: state.validate(state.password, username),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = event.password;
    emit(state.copyWith(
      password: password,
      formStatus: state.validate(password, state.username),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.formStatus is FormValidationSuccess) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        await _dataRepository.authenticate(
            username: state.username.toString(),
            password: state.password.toString());

        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (_) {
        emit(state.copyWith(formStatus: SubmissionFailed(_)));
      }
    }
  }
}
