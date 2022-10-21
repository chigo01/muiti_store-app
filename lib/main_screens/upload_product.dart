import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';

import 'package:multi_store_app/widgets/components/snackbar.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductsScreen> createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String productId;
  dynamic _pickedImageError;
  String? mainCategValue = 'select category';
  String? subCategValue = 'subcategory';
  List<String> subCategList = [];
  // Is the image class for pick an actual image
  List<XFile>? _imagesFileList = [];
  List<String> imageUrlList = [];
  bool processing = false;

  final ImagePicker _imagesPicker = ImagePicker(); //Instance of ImagePicker

  Future<void> pickProductImages() async {
    try {
      final pickedImages = await _imagesPicker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 95,
      );
      setState(() {
        _imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });

      log(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (_imagesFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: _imagesFileList!.length,
        itemBuilder: ((context, index) {
          //use image file widget from images picked from gallery
          return Image.file(File(_imagesFileList![index].path));
        }),
      );
    } else {
      return const Center(
        child: Text(
          'You have not  \n \n picked images yet!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  void selectedMainCategory(String? value) {
    if (value == 'select category') {
      subCategList = [];
    } else if (value == 'men') {
      subCategList = men;
    } else if (value == 'women') {
      subCategList = women;
    } else if (value == 'electronics') {
      subCategList = electronics;
    } else if (value == 'accessories') {
      subCategList = accessories;
    } else if (value == 'shoes') {
      subCategList = shoes;
    } else if (value == 'home & garden') {
      subCategList = homeandgarden;
    } else if (value == 'beauty') {
      subCategList = beauty;
    } else if (value == 'kids') {
      subCategList = kids;
    } else if (value == 'bags') {
      subCategList = bags;
    }
    log(value.toString());
    setState(() {
      mainCategValue = value;
      subCategValue = 'subcategory';
    });
  }

  Future<void> uploadImages() async {
    if (mainCategValue != 'select category' && subCategValue != 'subcategory') {
      if (_formKey.currentState!.validate()) {
        // using this function to saved all the inputs
        _formKey.currentState!.save();
        if (_imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in _imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('products/${path.basename(image.path)}');
              //passing the reference to save them by name or according to its path

              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imageUrlList.add(value);
                });
              });
            }
          } catch (e) {
            log(e.toString());
          }
        } else {
          MyMessageHandler.showSnackBar(
              _scaffoldKey, 'please pick images first');
        }
      } else {
        MyMessageHandler.showSnackBar(
          _scaffoldKey,
          'please fill all fields,',
        );
      }
    } else {
      MyMessageHandler.showSnackBar(
        _scaffoldKey,
        'please select categories',
      );
    }
  }

  void uploadData() async {
    if (imageUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection('products');

      //for generating a random id for oor firebase doc
      productId = const Uuid().v4();

      await productRef.doc(productId).set({
        'productid': productId,
        'maincateg': mainCategValue,
        'subcateg': subCategValue,
        'price': price,
        'instock': quantity,
        'proname': productName,
        'prodesc': productDescription,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imageUrlList,
        'discount': 0,
      }).whenComplete(() {
        setState(() {
          _imagesFileList = [];
          mainCategValue = 'select category';

          subCategList = [];
          imageUrlList = [];
          processing = false;
        });
        _formKey.currentState!.reset();
      });
    } else {
      log('no images');
    }
  }

  void uploadProduct() async {
    //when ever u want to await a function make the function a future
    await uploadImages().whenComplete(() => uploadData());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //when ever you use a form validator we need to wrap our widget with a form key
    // when you have a snackbar  always have a scaffold manager widget wrapped scaffold  widget ad global key of scaffold manager state class
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: _imagesFileList != null
                            ? previewImages()
                            : const Center(
                                child: Text(
                                  'You have not  \n \n picked images yet!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: size.width * 0.5,
                        width: size.width * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  '* select main category',
                                  style: TextStyle(color: Colors.red),
                                ),
                                Center(
                                  child: DropdownButton(
                                      //the value selected from the dropdown
                                      value: mainCategValue,
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: Colors.yellow.shade400,
                                      iconDisabledColor: Colors.black,
                                      menuMaxHeight: 500,
                                      disabledHint:
                                          const Text('Select category'),
                                      items: maincateg
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: ((String? value) {
                                        selectedMainCategory(value);
                                      })),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  '* select subcategory',
                                  style: TextStyle(color: Colors.red),
                                ),
                                Center(
                                  child: DropdownButton(
                                      //the value selected from the dropdown
                                      iconSize: 40,
                                      iconEnabledColor: Colors.red,
                                      dropdownColor: Colors.yellow.shade400,
                                      menuMaxHeight: 500,
                                      value: subCategValue,
                                      items: subCategList
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                      onChanged: ((String? value) {
                                        log(value.toString());
                                        setState(() {
                                          subCategValue = value;
                                        });
                                      })),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter price';
                          } else if (!value.isValidPrice()) {
                            return 'not valid price';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          price = double.parse(value!);
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: textFormDecoration.copyWith(
                          labelText: 'price',
                          hintText: r'price .. $',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter Quantity';
                          } else if (!value.isValidQuantity()) {
                            return 'not valid quantity';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          quantity = int.parse(value!);
                        },
                        keyboardType: TextInputType.number,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Quantity',
                          hintText: r'Add  Quantity',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter product name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productName = value!;
                        },
                        maxLength: 100,
                        maxLines: 3,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'product name',
                          hintText: r'Enter your product name',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter product description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          productDescription = value!;
                        },
                        maxLength: 800,
                        maxLines: 5,
                        decoration: textFormDecoration.copyWith(
                          labelText: 'product description',
                          hintText: r'Enter product description',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: _imagesFileList!.isEmpty
                    ? () {
                        pickProductImages();
                      }
                    : () {
                        setState(() {
                          _imagesFileList = [];
                        });
                      },
                backgroundColor: Colors.yellow,
                child: _imagesFileList!.isEmpty
                    ? const Icon(
                        Icons.photo_library,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                      uploadProduct();
                    },
              backgroundColor: Colors.yellow,
              child: processing == true
                  ? const CircularProgressIndicator(color: Colors.black)
                  : const Icon(
                      Icons.upload,
                      color: Colors.black,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: r'price .. $',
  labelStyle: const TextStyle(color: Colors.purple),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.yellow, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
  ),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
    //accepts first number from 1-9 and second number from 0-9 multiple the values
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
    //accepts first number from 1-9 and second number from 0-9 multiple the values
    //{} stands for optional range
  }
}
