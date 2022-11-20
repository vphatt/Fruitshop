import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../shared/dialog_utils.dart';
import 'products_manager.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    this.product = product!;
  }
  late final Product product;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  var _isLoading = false;
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chỉnh sửa sản phẩm'),
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.save),
            //   onPressed: _saveForm,
            // ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _editForm,
                    child: ListView(
                      children: <Widget>[
                        Text('Tên sản phẩm: '),
                        buildTitleField(),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Giá sản phẩm: '),
                        buildPriceField(),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Mô tả sản phẩm: '),
                        buildDescriptionField(),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Ảnh sản phẩm: '),
                        buildProductPreview(),
                        SizedBox(
                          height: 20,
                        ),
                        _buildSubmitButton(),
                      ],
                    )),
              ));
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập vào tên sản phẩm.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _saveForm,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.headline6?.color,
        ),
      ),
      child: Text('Cập nhật'),
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.price.toStringAsFixed(0).toString(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập vào giá sản phẩm.';
        }
        if (double.tryParse(value) == null) {
          return 'Nhập vào số.';
        }
        if (double.parse(value) <= 0) {
          return 'Nhập vào giá lớn hơn 0.';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập vào mô tả.';
        }
        if (value.length < 10) {
          return 'Mô tả it nhất phải 10 ký tự.';
        }

        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _imageUrlController.text.isEmpty
              ? const Text('')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        )
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: 'URL ảnh'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập vào URL ảnh sản phẩm.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Nhập vào URL ảnh hợp lệ.';
        }

        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(imageUrl: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }

    _editForm.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final productsManager = context.read<ProductsManager>();

      await productsManager.updateProduct(_editedProduct);
    } catch (error) {
      await showErrorDialog(context, 'Đã có lỗi xảy ra.');
    }
    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
