import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  static final routeName = "ProductPage";

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
        child: Column(
          children: [
            _nameTextFormField(),
            Divider(),
            _priceTextFormField(),
            Divider(),
            _switchTile(),
            Divider(),
            _saveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _nameTextFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Nombre"),
    );
  }

  Widget _priceTextFormField() {
    return TextFormField(
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
      value: false,
      onChanged: (newValue) {},
    );
  }

  Widget _saveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor, // background
          onPrimary: Colors.black, // foreground
        ),
        icon: Icon(Icons.save),
        label: Text("Guardar"),
        onPressed: () {},
      ),
    );
  }
}
