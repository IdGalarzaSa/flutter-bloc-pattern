import 'package:flutter/material.dart';
import 'package:form_validation_bloc_pattern/src/bloc/login_bloc.dart';

class ProviderBloc extends InheritedWidget {
  // Instanciamos la clase bloc que contiene los streams
  final loginBloc = LoginBloc();
  static ProviderBloc _instance;

  factory ProviderBloc({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new ProviderBloc._internal(key: key, child: child);
    }
    return _instance;
  }

  ProviderBloc._internal({Key key, Widget child})
      : super(key: key, child: child);

  /*
  Este metodo se ejecuta cada vez que se actualiza informaciön.
  Aqui podemos controlar si es necesario notificar o no a sus widgets hijos.
  Por lo general siempre es true.
  */

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // throw UnimplementedError();
    return true;
  }

  /*
  Toma el contexto y busca un widget que cuente exactamente con el provider
  especificado.
  */
  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderBloc>().loginBloc;
  }
}
