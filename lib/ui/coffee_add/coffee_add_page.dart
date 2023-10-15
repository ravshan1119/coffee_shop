import 'dart:io';

import 'package:coffee_shop/cubits/coffee_add/coffee_add_cubit.dart';
import 'package:coffee_shop/data/firebase/coffee_service.dart';
import 'package:coffee_shop/data/model/coffee_model.dart';
import 'package:coffee_shop/data/universal_data.dart';
import 'package:coffee_shop/ui/utils/loading_dialog.dart';
import 'package:coffee_shop/ui/utils/utils.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/ui/widgets/global_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

  String imagePath = defaultImageConstant;

  String? selectedImagePath;
  String? selectedImagePathTwo;

  @override
  void initState() {
    super.initState();
    selectedImagePath != null;
    selectedImagePathTwo != null;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 270,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: selectedImagePath == null
                            ? Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: GestureDetector(
                                    onTap: () {
                                      showCameraAndGalleryDialog(context,
                                          (imagePath) {
                                        if (imagePath != null) {
                                          setState(() {
                                            selectedImagePath = imagePath;
                                          });
                                        }
                                      });
                                    },
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera,
                                            size: 64,
                                          ),
                                          Text(
                                            "Picture",
                                            style: TextStyle(fontSize: 24),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Image.file(
                                File(selectedImagePath!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 270,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: selectedImagePathTwo == null
                            ? Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white),
                                  child: GestureDetector(
                                    onTap: () {
                                      showCameraAndGalleryDialog(context,
                                          (imagePath) {
                                        if (imagePath != null) {
                                          setState(() {
                                            selectedImagePathTwo = imagePath;
                                          });
                                        }
                                      });
                                    },
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.camera,
                                          size: 64,
                                        ),
                                        Text(
                                          "Picture Art",
                                          style: TextStyle(fontSize: 24),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Image.file(
                                File(selectedImagePathTwo!),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
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
                          picture: selectedImagePath!,
                          description: descriptionController.text,
                          pictureAlt: selectedImagePathTwo!,
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
}
