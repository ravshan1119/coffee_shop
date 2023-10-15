import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:coffee_shop/ui/widgets/global_input.dart';
import 'package:flutter/material.dart';

class CoffeeAddPage extends StatelessWidget {
  const CoffeeAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee Add"),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: GlobalTextField(hintText: "Name"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: GlobalTextField(hintText: "Price",keyboardType: TextInputType.phone,),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: GlobalTextField(hintText: "Description",maxLines: 5,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlobalButton(title: "Picture",color: Colors.green, onTap: () {}),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlobalButton(title: "PictureArt",color: Colors.green, onTap: () {}),
          ),
        ],
      ),
    );
  }
}
