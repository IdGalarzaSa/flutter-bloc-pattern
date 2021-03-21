import 'dart:async';

import 'package:form_validation_bloc_pattern/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  // Init like Stream mode
  // final _emailController = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();

  // Init like RXDart mode
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Obtener los datos del stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidation);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidation);

  // Combinar dos streams mediante RxDart
  Stream<bool> get validationFormStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  // Insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtner los ultimos valores del stream

  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
