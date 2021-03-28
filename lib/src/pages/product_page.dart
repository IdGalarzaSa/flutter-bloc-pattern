import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validation_bloc_pattern/src/models/product_model.dart';
import 'package:form_validation_bloc_pattern/src/providers/product_provider.dart';

class ProductPage extends StatefulWidget {
  static final routeName = "ProductPage";

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductModel product = new ProductModel();
  ProductProvider productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.image), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              _nameTextFormField(),
              Divider(),
              _priceTextFormField(),
              Divider(),
              _switchTile(),
              Divider(),
              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameTextFormField() {
    return TextFormField(
      initialValue: product.titulo,
      decoration: InputDecoration(labelText: "Nombre"),
    );
  }

  Widget _priceTextFormField() {
    return TextFormField(
      initialValue: product.valor.toString(),
      decoration: InputDecoration(labelText: "Precio"),
    );
  }

  Widget _switchTile() {
    return SwitchListTile(
      title: Text(
        "Disponible",
        style: TextStyle(color: ThemeData.dark().accentColor),
      ),
      activeColor: ThemeData.dark().accentColor,
      value: product.disponible,
      onChanged: (newValue) {
        product.disponible = newValue;
        setState(() {});
      },
    );
  }

  Widget _saveButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor, // background
          onPrimary: Colors.black, // foreground
        ),
        icon: Icon(Icons.save),
        label: Text("Guardar"),
        onPressed: saveButton,
      ),
    );
  }

  void saveButton() {
    productProvider.createProduct(product);
    Navigator.pop(context);
  }
}
