import 'dart:io';
import 'package:coffee_shop/cubits/coffee_add/coffee_add_cubit.dart';
import 'package:coffee_shop/data/firebase/coffee_service.dart';
import 'package:coffee_shop/data/model/coffee_model.dart';
import 'package:coffee_shop/data/universal_data.dart';
import 'package:coffee_shop/ui/utils/loading_dialog.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/ui/widgets/global_input.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CoffeeAddPage extends StatefulWidget {
  const CoffeeAddPage({super.key});

  @override
  State<CoffeeAddPage> createState() => _CoffeeAddPageState();
}

class _CoffeeAddPageState extends State<CoffeeAddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CoffeeService coffeeService = CoffeeService();

  ImagePicker pickerOne = ImagePicker();
  ImagePicker pickerTwo = ImagePicker();

  File? _photo;
  File? _photoTwo;

  var storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _photo != null;
    _photoTwo != null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeAddCubit, CoffeeAddState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Coffee Add"),
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GlobalTextField(
                      hintText: "Name",
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GlobalTextField(
                      hintText: "Price",
                      controller: priceController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GlobalTextField(
                      hintText: "Description",
                      controller: descriptionController,
                      maxLines: 5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: const Color(0xffFDCF09),
                                child: _photo != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          _photo!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const Text("picture one"),
                        ],
                      ),
                      Column(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                _showPickerTwo(context);
                              },
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: const Color(0xffFDCF09),
                                child: _photoTwo != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.file(
                                          _photoTwo!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width: 100,
                                        height: 100,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const Text("picture two"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlobalButton(
                    title: "Add",
                    onTap: () async {
                      if (nameController.text.isNotEmpty &&
                          priceController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty) {
                        CoffeeModel coffeeModel = CoffeeModel(
                          id: "",
                          name: nameController.text,
                          price: double.parse(priceController.text),
                          picture: _photo!.path,
                          description: descriptionController.text,
                          pictureAlt: _photoTwo!.path,
                        );

                        showLoading(context: context);
                        UniversalData universalData = await coffeeService
                            .addProduct(coffeeModel: coffeeModel);
                        if (context.mounted) {
                          hideLoading(dialogContext: context);
                        }
                        if (universalData.error.isEmpty && context.mounted) {
                          var snackBar = SnackBar(
                            content: Text(universalData.data.toString()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          var snackBar = SnackBar(
                            content: Text(universalData.error.toString()),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      } else {
                        const snackBar = SnackBar(
                          content: Text('The field is not full!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    color: Colors.greenAccent.shade200,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future imgFromGallery() async {
    final pickedFile = await pickerOne.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future imgFromGalleryTwo() async {
    final pickedFile = await pickerOne.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photoTwo = File(pickedFile.path);
        uploadFile();
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await pickerOne.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future imgFromCameraTwo() async {
    final pickedFile = await pickerOne.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photoTwo = File(pickedFile.path);
        uploadFile();
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(_photo!);
    } catch (e) {
      debugPrint('error occured');
    }
  }

  Future uploadFileTwo() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(_photo!);
    } catch (e) {
      debugPrint('error occured');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showPickerTwo(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGalleryTwo();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCameraTwo();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
