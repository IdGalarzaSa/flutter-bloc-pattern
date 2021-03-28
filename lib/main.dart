import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validation_bloc_pattern/src/bloc/provider.dart';
import 'package:form_validation_bloc_pattern/src/pages/home_page.dart';
import 'package:form_validation_bloc_pattern/src/pages/login_page.dart';
import 'package:form_validation_bloc_pattern/src/pages/product_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: MaterialApp(
        title: 'Material App',
        initialRoute: HomePage.routeName,
        routes: {
          LoginPage.routeName: (BuildContext context) => LoginPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          ProductPage.routeName: (BuildContext context) => ProductPage(),
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}
