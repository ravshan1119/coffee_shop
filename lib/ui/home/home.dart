import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/data/model/coffee_model.dart';
import 'package:coffee_shop/ui/coffee_add/coffee_add_page.dart';
import 'package:coffee_shop/ui/home/components/food.dart';
import 'package:coffee_shop/ui/home/components/rotate_food.dart';
import 'package:coffee_shop/ui/home/providers/transition_provider.dart';
import 'package:coffee_shop/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentIndex = 0;
  late PageController _pageController;

  final Stream<QuerySnapshot> coffees =
      FirebaseFirestore.instance.collection('coffee').snapshots();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    // PreCacheImages.preCacheImages(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: coffees,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Transform(
            transform: Matrix4.identity()..rotateZ(pi / 4),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color(0xff45C37B).withOpacity(0.5),
                  offset: const Offset(2, 5),
                  blurRadius: 15,
                )
              ]),
              child: FloatingActionButton(
                mini: true,
                elevation: 0,
                backgroundColor: const Color(0xff45C37B),
                onPressed: () {
                  // CoffeeModel coffeeModel = CoffeeModel(
                  //   id: snapshot.data["id"],
                  //   name: name,
                  //   price: price,
                  //   picture: picture,
                  //   description: description,
                  //   pictureAlt: pictureAlt,
                  // );
                  navigateToDetail(CoffeeModel(
                    id: snapshot.data!.docs[currentIndex]["id"],
                    name: snapshot.data!.docs[currentIndex]["name"],
                    price: snapshot.data!.docs[currentIndex]["price"],
                    picture: snapshot.data!.docs[currentIndex]["picture"],
                    description: snapshot.data!.docs[currentIndex]
                    ["description"],
                    pictureAlt: snapshot.data!.docs[currentIndex]
                    ["picture_alt"],
                  ), context);
                },
                child: Transform(
                  transform: Matrix4.identity()..rotateZ(-pi / 4),
                  alignment: Alignment.center,
                  child: Icon(
                    UniconsLine.arrow_right,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CoffeeAddPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  )),
            ],
            forceMaterialTransparency: true,
          ),
          body: Stack(
            children: [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                  ref.read(textAnimationIndex.notifier).state = null;
                },
                itemBuilder: (context, index) {
                  final random = Random();
                  return Container(
                    color: colors[random.nextInt(colors.length)]
                  );
                },
                itemCount: snapshot.data!.docs.length,
              ),
              Food(
                  foodDetail: CoffeeModel(
                    id: snapshot.data!.docs[currentIndex]["id"],
                    name: snapshot.data!.docs[currentIndex]["name"],
                    price: snapshot.data!.docs[currentIndex]["price"],
                    picture: snapshot.data!.docs[currentIndex]["picture"],
                    description: snapshot.data!.docs[currentIndex]
                        ["description"],
                    pictureAlt: snapshot.data!.docs[currentIndex]
                        ["picture_alt"],
                  ),
                  pageController: _pageController),
              Positioned(
                top: height / 2 - (width * 0.88) / 2,
                left: width / 2 - 20,
                child: RotateFood(
                  currentIndex: currentIndex,
                  width: width,
                  pageController: _pageController,
                ),
              )
            ],
          ),
        );

        ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          }).toList(),
        );
      },
    );
  }
}

List<Color> colors = [Colors.white];
