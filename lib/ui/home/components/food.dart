import 'package:coffee_shop/data/model/coffee_model.dart';
import 'package:coffee_shop/ui/home/components/animate_text.dart';
import 'package:coffee_shop/ui/home/providers/transition_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Food extends ConsumerStatefulWidget {
  final CoffeeModel foodDetail;
  final PageController pageController;
  const Food(
      {super.key, required this.foodDetail, required this.pageController});

  @override
  ConsumerState<Food> createState() => _FoodState();
}

class _FoodState extends ConsumerState<Food> with TickerProviderStateMixin {
  late AnimationController _controller;
  int? reverseIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        lowerBound: 0,
        upperBound: 1);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    reverseIndex = ref.watch(textAnimationIndex);

    if (reverseIndex != null && reverseIndex == widget.pageController.page) {
      _controller.reverse().then((value) => _controller.forward());
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Hero(
                tag: widget.foodDetail.name,
                child: Material(
                  type: MaterialType.transparency,
                  child: AnimateText(
                    widget.foodDetail.name,
                    style: GoogleFonts.ibmPlexSerif().copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                    controller: _controller,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            AnimatedTile(
              data: Attribute(
                  icon: const Icon(
                    Icons.access_time,
                    color: Colors.green,
                  ),
                  title: "10 min"),
              animate: false,
            ),
            AnimatedTile(
              data: Attribute(
                  icon: const Icon(
                    Icons.price_change,
                    color: Colors.green,
                  ),
                  title: widget.foodDetail.price.toString()),
              animate: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/5,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: AnimateText(
                    widget.foodDetail.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    controller: _controller,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTile extends StatelessWidget {
  final Attribute data;
  final bool animate;
  final AnimationController? controller;
  const AnimatedTile(
      {super.key, required this.data, this.controller, this.animate = true});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        leading: Hero(tag: data.icon, child: data.icon),
        title: Hero(
          tag: data.title,
          child: Material(
            type: MaterialType.transparency,
            child: animate
                ? AnimateText(
                    data.title,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                    controller: controller!,
                  )
                : Text(
                    data.title,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ),
    );
  }
}
