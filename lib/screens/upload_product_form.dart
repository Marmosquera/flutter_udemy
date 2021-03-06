import 'dart:io';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/consts/app_icons.dart';
import 'package:udemy_course/models/product_input.dart';
import 'package:udemy_course/providers/products_provider.dart';
import 'package:udemy_course/widgets/app_dialogs.dart';

import '/consts/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  ProductInput _product = ProductInput();
  late ProductsProvider _productsProvider;

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      await _productsProvider.saveProduct(_product);
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _product.pickedImage = pickedImageFile;
    });
  }

  void _pickImageUrl() async {
    final TextEditingController _textFieldController = TextEditingController();
    await AppDialogs.showInputTextDialog(
        context, 'Image Url', 'Image Url', _textFieldController, () {},
        () async {
      final uri = Uri.parse(_textFieldController.text);
      //final response = await http.get(uri);
      //final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File.fromUri(uri);
      //file.writeAsBytesSync(response.bodyBytes);
      setState(() {
        _product.pickedImage = file;
      });
    });
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _product.pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _product.pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text('Upload',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center),
                ),
                GradientIcon(
                  AppIcons.upload,
                  20,
                  LinearGradient(
                    colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellow
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  key: ValueKey('Title'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a Title';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Product Title',
                                  ),
                                  onSaved: (value) {
                                    _product.title = value ?? '';
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextFormField(
                                key: ValueKey('Price \$'),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Price is missed';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Price \$',
                                  //  prefixIcon: Icon(Icons.mail),
                                  // suffixIcon: Text(
                                  //   '\n \n \$',
                                  //   textAlign: TextAlign.start,
                                  // ),
                                ),
                                //obscureText: true,
                                onSaved: (value) {
                                  _product.price = double.parse(value ?? '0');
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        /* Image picker here ***********************************/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              //  flex: 2,
                              child: _product.pickedImage == null
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius: BorderRadius.circular(4),
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                        child: _product.pickedImage == null
                                            ? null
                                            : Image.file(
                                                _product.pickedImage!,
                                                fit: BoxFit.contain,
                                                alignment: Alignment.center,
                                              ),
                                      ),
                                    ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: TextButton(
                                    onPressed: _pickImageCamera,
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera,
                                            color: Colors.purpleAccent),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Camera',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: _pickImageGallery,
                                    child: Row(
                                      children: [
                                        Icon(AppIcons.gallery,
                                            color: Colors.purpleAccent),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Gallery',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: _pickImageUrl,
                                    child: Row(
                                      children: [
                                        Icon(AppIcons.cloud,
                                            color: Colors.purpleAccent),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Url',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: TextButton(
                                    onPressed: _removeImage,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.remove_circle_rounded,
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Remove',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    controller: _categoryController,
                                    key: ValueKey('Category'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a Category';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Add a new Category',
                                    ),
                                    onSaved: (value) {
                                      _product.productCategoryName =
                                          value ?? '';
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Phones'),
                                  value: 'Phones',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Clothes'),
                                  value: 'Clothes',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Beauty & health'),
                                  value: 'Beauty',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Shoes'),
                                  value: 'Shoes',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Funiture'),
                                  value: 'Funiture',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Watches'),
                                  value: 'Watches',
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _product.productCategoryName = value!;
                                  _categoryController.text = value;
                                  print(_product.productCategoryName);
                                });
                              },
                              hint: Text('Select a Category'),
                              //value: _categoryValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: Container(
                                  child: TextFormField(
                                    controller: _brandController,
                                    key: ValueKey('Brand'),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Brand is missed';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Brand',
                                    ),
                                    onSaved: (value) {
                                      _product.brand = value ?? '';
                                    },
                                  ),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Brandless'),
                                  value: 'Brandless',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Addidas'),
                                  value: 'Addidas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Apple'),
                                  value: 'Apple',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Dell'),
                                  value: 'Dell',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('H&M'),
                                  value: 'H&M',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Nike'),
                                  value: 'Nike',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Samsung'),
                                  value: 'Samsung',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Huawei'),
                                  value: 'Huawei',
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _product.brand = value!;
                                  _brandController.text = value;
                                  print(_product.brand);
                                });
                              },
                              hint: Text('Select a Brand'),
                              //value: _brandValue,
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                            key: ValueKey('Description'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'product description is required';
                              }
                              return null;
                            },
                            //controller: this._controller,
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              //  counterText: charLength.toString(),
                              labelText: 'Description',
                              hintText: 'Product description',
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (value) {
                              _product.description = value ?? '';
                            },
                            onChanged: (text) {
                              // setState(() => charLength -= text.length);
                            }),
                        //    SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              //flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: ValueKey('Quantity'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Quantity is missed';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                  onSaved: (value) {
                                    _product.quantity = int.parse(value ?? '0');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              //flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 9),
                                child: ListTileSwitch(
                                  value: _product.isPopular,
                                  onChanged: (value) {
                                    setState(() {
                                      _product.isPopular = value;
                                    });
                                  },
                                  visualDensity: VisualDensity.comfortable,
                                  switchType: SwitchType.cupertino,
                                  switchActiveColor: Colors.indigo,
                                  title: const Text(
                                    'Is Popular?',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
