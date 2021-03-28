import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validation_bloc_pattern/src/models/product_model.dart';
import 'package:form_validation_bloc_pattern/src/providers/product_provider.dart';
import 'package:form_validation_bloc_pattern/src/utils/validations.dart';

class ProductPage extends StatefulWidget {
  static final routeName = "ProductPage";

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductModel _product = new ProductModel();
  ProductProvider _productProvider = new ProductProvider();

  final formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    ProductModel _previousProduct = ModalRoute.of(context).settings.arguments;
    if (_previousProduct != null) {
      _product = _previousProduct;
    }

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
          key: formKey,
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
      initialValue: _product.titulo,
      decoration: InputDecoration(labelText: "Nombre"),
      validator: (currentName) {
        return currentName != null && currentName.length > 3
            ? null
            : "El nombre del producto no es valido";
      },
      onSaved: (newProductName) {
        _product.titulo = newProductName;
      },
    );
  }

  Widget _priceTextFormField() {
    return TextFormField(
      initialValue: _product.valor.toString(),
      decoration: InputDecoration(labelText: "Precio"),
      validator: (currentPrice) {
        return isNumeric(currentPrice) ? null : "No es un número valido";
      },
      onSaved: (newProductPrice) {
        _product.valor = double.parse(newProductPrice);
      },
    );
  }

  Widget _switchTile() {
    return SwitchListTile(
      title: Text(
        "Disponible",
        style: TextStyle(color: ThemeData.dark().accentColor),
      ),
      activeColor: ThemeData.dark().accentColor,
      value: _product.disponible,
      onChanged: (newValue) {
        _product.disponible = newValue;
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
        onPressed: isSaving ? null : saveButton,
      ),
    );
  }

  Future<void> saveButton() async {
    if (formKey.currentState.validate()) {
      isSaving = true;
      setState(() {});
      formKey.currentState.save();

      if (_product.id == null) {
        await _productProvider.createProduct(_product);
        showSnackBar('Producto creado');
      } else {
        await _productProvider.editProduct(_product);
        showSnackBar('Producto editado');
      }
      Navigator.pop(context);
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
