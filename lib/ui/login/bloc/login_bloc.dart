import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/auth_service.dart';


abstract class LoginState extends Equatable {
const LoginState();
@override
List<Object> get props => [];
}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginFailure extends LoginState {
final String error;
const LoginFailure({required this.error});
@override
List<Object> get props => [error];
}

abstract class LoginEvent extends Equatable {
const LoginEvent();
@override
List<Object> get props => [];
}
class LoginButtonPressed extends LoginEvent {
final String username;
final String password;
const LoginButtonPressed({required this.username, required this.password});
@override
List<Object> get props => [username, password];
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
final AuthService authService;
LoginBloc({required this.authService}) : super(LoginInitial()) {
on<LoginButtonPressed>((event, emit) async {
emit(LoginLoading());
try {
final isSuccess = await authService.login(event.username,
event.password);
if (isSuccess) {
emit(LoginSuccess());
} else {
emit(const LoginFailure(error: "Invalid username or password"));
}
} catch (e) {
emit(LoginFailure(error: e.toString()));
}
});
}
}

