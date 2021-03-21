import 'dart:async';

class Validators {
  final passwordValidation = StreamTransformer<String, String>.fromHandlers(
      /*
    El sink maneja valor que vamos a enviar mediante este metodo. Ya sea una
    respuesta correcta mediante el "add" o un error mediante el "addError".
    Ambos casos de respuesta son excluyentes. Si enviamos la respuesta mediante 
    un "add" entonces el "addError" devolvera null y viceversa.
    */
      handleData: (newPassword, sink) {
    if (newPassword.length >= 6) {
      // Si
      sink.add(newPassword);
    } else {
      // Mientras que no cumpla la condicion deseada, devolveremos un error
      sink.addError('La contraseña debe contener más de 6 caracteres.');
    }
  });

  final emailValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (newEmail, sink) {
    // Sirve para expresiones regulars o regex
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(newEmail)) {
      sink.add(newEmail);
    } else {
      sink.addError('El email no es valido');
    }
  });
}
