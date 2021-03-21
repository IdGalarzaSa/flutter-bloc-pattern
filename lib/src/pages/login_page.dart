import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validation_bloc_pattern/src/bloc/login_bloc.dart';
import 'package:form_validation_bloc_pattern/src/bloc/provider.dart';
import 'package:form_validation_bloc_pattern/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  static final routeName = "LoginPage";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _stackBackground(context, size),
          _loginForm(context, size),
        ],
      ),
    );
  }

  Widget _stackBackground(BuildContext context, Size size) {
    final purpleBackground = Container(
      height: size.height * 0.40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );

    final circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(225, 225, 225, 0.05)),
    );

    final columnData = SafeArea(
        child: Container(
      padding: EdgeInsets.only(top: 20),
      height: size.height * 0.40,
      child: Column(
        children: [
          Icon(Icons.person_pin_circle, color: Colors.white, size: 100),
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          Text("Ivan Galarza",
              style: TextStyle(color: Colors.white, fontSize: 30))
        ],
      ),
    ));

    return Stack(
      children: [
        purpleBackground,
        Positioned(child: circle, top: 90, left: 25),
        Positioned(child: circle, top: -20, right: -20),
        Positioned(child: circle, bottom: 20, right: 25),
        Positioned(child: circle, bottom: -50, left: 15),
        Positioned(child: circle, bottom: 160, right: 100),
        columnData,
      ],
    );
  }

  Widget _loginForm(BuildContext context, Size size) {
    final LoginBloc bloc = ProviderBloc.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(vertical: 30.0),
            width: size.width * 0.85,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: [
                Text('Ingreso',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                SizedBox(height: 30.0),
                _emailTextField(bloc),
                SizedBox(height: 15.0),
                _passwordTextField(bloc),
                SizedBox(height: 15.0),
                _loginButton(context, bloc),
                SizedBox(height: 15.0),
                Text("¿Olvido su contraseña?",
                    style: TextStyle(color: Colors.deepPurple)),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _emailTextField(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'ejemplo@gmail.com',
              labelText: 'Correo electrónico',
              errorMaxLines: 3,
              errorText: snapshot.error,
            ),
            onChanged: loginBloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _passwordTextField(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Contraseña',
              errorText: snapshot.error,
              errorMaxLines: 3,
            ),
            onChanged: loginBloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _loginButton(BuildContext context, LoginBloc loginBloc) {
    return StreamBuilder<Object>(
      stream: loginBloc.validationFormStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
            child: Text(
              'Ingresar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            elevation: 10,
          ),
          onPressed: snapshot.hasData ? () => _login(context, loginBloc) : null,
        );
      },
    );
  }

  _login(BuildContext context, LoginBloc loginBloc) {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }
}
