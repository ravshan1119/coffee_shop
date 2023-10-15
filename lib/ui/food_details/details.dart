import 'package:coffee_shop/data/model/food_detail.dart';
import 'package:coffee_shop/ui/home/components/food.dart';
import 'package:coffee_shop/ui/widgets/global_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

class FoodRecipe extends StatefulWidget {
  final FoodDetail detail;
  const FoodRecipe({super.key, required this.detail});

  @override
  State<FoodRecipe> createState() => _FoodRecipeState();
}

class _FoodRecipeState extends State<FoodRecipe>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: widget.detail.colorScheme!.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            UniconsLine.arrow_left,
            size: 30,
            color: widget.detail.textColor,
          ),
          onPressed: () {
            _animationController.reverse();
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Hero(
                    tag: widget.detail.pictureAlt!,
                    child:
                        Image.asset('lib/assets/${widget.detail.pictureAlt}')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Hero(
                tag: widget.detail.name!,
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    widget.detail.name!,
                    style: GoogleFonts.ibmPlexSerif().copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                      color: widget.detail.textColor,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: AnimatedTile(
                    data: widget.detail.attributes![0],
                    animate: false,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    child: AnimatedTile(
                      data: widget.detail.attributes![1],
                      animate: false,
                    ),
                  ),
                ),
              ],
            ),
            Text(widget.detail.description!,style: TextStyle(
              color: widget.detail.textColor,
              fontSize: 12
            ),),
            const SizedBox(height: 50),
            GlobalButton(title: "Buy now", onTap: (){},color: Colors.green,),
          ],
        ),
      ),
    );
  }
}
