import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product_model.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductPage extends StatefulWidget {
  static String routeName = 'edit';

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  Product product;
  String _title = '';
  double _price = 0.0;
  String _desc = '';
  String _url = '';
  bool _isLoading = false;
  FocusNode _titleNode = FocusNode();
  FocusNode _priceNode = FocusNode();
  FocusNode _descNode = FocusNode();
  final _form = GlobalKey<FormState>();

  TextEditingController _imageUrlController = TextEditingController();

  _saveForm(String id) async {
    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
    Product updatedProduct = Product(
        id: id,
        title: _title,
        description: _desc,
        price: _price,
        imageUrl: _url);

    await Provider.of<ProductsProvider>(context, listen: false)
        .updateProduct(id, updatedProduct);
    await Future.delayed(Duration(milliseconds: 150));
    Navigator.of(context).pop();
    // print('${updatedProduct.title} before oupdatge');
    // print('${updatedProduct.title} SECOND UPDATED');
  }

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context).settings.arguments as Product;
    _title = product.title;
    _price = product.price;
    _desc = product.description;
    _url = product.imageUrl;

    return Scaffold(
        appBar: AppBar(title: Text('Edit product ${product.title}')),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //nombre
                        TextFormField(
                          initialValue: _title,
                          focusNode: _titleNode,
                          onSaved: (value) {
                            _title = value;
                            print(_title);
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              label: Text('current title: ${_title}'),
                              hintText: 'Enter new title'),
                        ),
                        //precio
                        TextFormField(
                          initialValue: _price.toString(),
                          focusNode: _priceNode,
                          onSaved: (value) {
                            _price = double.parse(value);
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              label: Text('Current price: ${_price}'),
                              hintText: 'Enter new price'),
                        ),
                        //descripcion
                        TextFormField(
                          initialValue: _desc,
                          maxLines: 3,
                          onSaved: (value) {
                            _desc = value;
                          },
                          focusNode: _descNode,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              label: Text('Description'), hintText: _desc),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 8,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: _imageUrlController.text.isEmpty
                                  ? Text('Enter a URL')
                                  : FittedBox(
                                      child: Image.network(
                                        _imageUrlController.text,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: _url,
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                // controller: _imageUrlController,
                                onFieldSubmitted: (value) {
                                  //proudcte

                                  _saveForm(product.id);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'El producto debe tener una imagen';
                                  }
                                  if (!value.startsWith('http') ||
                                      !value.startsWith('https')) {
                                    return 'Error. Debes introducir una URL';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _url = value;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
