import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validation_bloc_pattern/src/bloc/login_bloc.dart';
import 'package:form_validation_bloc_pattern/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = "HomePage";

  @override
  Widget build(BuildContext context) {
    final loginBloc = ProviderBloc.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Usuario: ${loginBloc.email}"),
          Divider(),
          Text("Password: ${loginBloc.password}")
        ],
      ),
    );
  }
}
