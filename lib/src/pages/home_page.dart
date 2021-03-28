import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_validation_bloc_pattern/src/bloc/login_bloc.dart';
import 'package:form_validation_bloc_pattern/src/bloc/provider.dart';
import 'package:form_validation_bloc_pattern/src/models/product_model.dart';
import 'package:form_validation_bloc_pattern/src/pages/product_page.dart';
import 'package:form_validation_bloc_pattern/src/providers/product_provider.dart';

class HomePage extends StatefulWidget {
  static final routeName = "HomePage";
  ProductProvider productProvider = new ProductProvider();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> _myCurrentProductList = [];

  @override
  Widget build(BuildContext context) {
    // final loginBloc = ProviderBloc.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ProductPage.routeName)
              .then((value) => setState(() {}));
        },
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return FutureBuilder(
      future: widget.productProvider.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          _myCurrentProductList = snapshot.data;
          return _productList();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _productList() {
    return ListView.builder(
      itemCount: _myCurrentProductList.length,
      itemBuilder: (BuildContext context, int index) {
        final currentProduct = _myCurrentProductList[index];
        return itemList(currentProduct);
      },
    );
  }

  Widget itemList(ProductModel currentProduct) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Center(
            child: Text(
          "Deleting...",
          style: TextStyle(fontSize: 25),
        )),
      ),
      onDismissed: (dirrection) {
        setState(() {
          _myCurrentProductList.remove(currentProduct);
        });
        widget.productProvider.deleteProduct(currentProduct);
      },
      child: ListTile(
        title: Text(currentProduct.titulo),
        trailing: Text(currentProduct.valor.toString()),
        subtitle: Text(currentProduct.id),
      ),
    );
  }
}
