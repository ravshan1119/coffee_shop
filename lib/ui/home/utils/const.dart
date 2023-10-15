import 'package:coffee_shop/data/model/food_detail.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

List<FoodDetail> foodList = [
  FoodDetail(
    name: "Cappuccino",
    colorScheme: const ColorScheme.light(),
    attributes: [
      Attribute(
          icon: const Icon(UniconsLine.stopwatch, color: Color(0xff45C37B)),
          title: "10 mins"),
      Attribute(
          icon: const Icon(UniconsLine.pricetag_alt, color: Color(0xff45C37B)),
          title: "\$ 1.5"),
    ],
    textColor: const Color(0xff171f52),
    description:
        'A single espresso shot poured into hot foamy milk, with the surface topped with mildly sweetened cocoa powder and drizzled with scrumptious caramel syrup...',
    picture: "Plate-1.png",
    pictureAlt: 'Plate-1-alt.png',
  ),

  FoodDetail(
    name: "Drizzled with Caramel",
    colorScheme: const ColorScheme.dark(
      background: Color(0xff223242),
    ),
    textColor: Colors.white,
    attributes: [
      Attribute(
          icon: const Icon(UniconsLine.stopwatch, color: Color(0xff45C37B)),
          title: "10 mins"),
      Attribute(
          icon: const Icon(UniconsLine.pricetag_alt, color: Color(0xff45C37B)),
          title: "\$ 2.6"),
    ],
    description:
        'Be it any occasion, we all love to eat pizza at home. But, what goes behind making this delicious dish? Well, learn all about making a delicious pizza at home with this easy recipe',
    picture: "Plate-3.png",
    pictureAlt: "Plate-3-alt.png",
  ),
  FoodDetail(
    name: "Bursting Blueberry",
    colorScheme: const ColorScheme.light(),
    textColor: const Color(0xff171f52),
    attributes: [
      Attribute(
          icon: const Icon(UniconsLine.stopwatch, color: Color(0xff45C37B)),
          title: "10 mins"),
      Attribute(
          icon: const Icon(UniconsLine.pricetag_alt, color: Color(0xff45C37B)),
          title: "\$ 1.4"),
    ],
    description:
        'Be it any occasion, we all love to eat pizza at home. But, what goes behind making this delicious dish? Well, learn all about making a delicious pizza at home with this easy recipe',
    picture: "Plate-2.png",
    pictureAlt: "Plate-2-alt.png",
  ),
  FoodDetail(
    name: "Cinnamon & Cocoa",
    colorScheme: const ColorScheme.dark(
      background: Color(0xff223242),
    ),
    textColor: Colors.white,
    attributes: [
      Attribute(
          icon: const Icon(UniconsLine.stopwatch, color: Color(0xff45C37B)),
          title: "10 mins"),
      Attribute(
          icon: const Icon(UniconsLine.pricetag_alt, color: Color(0xff45C37B)),
          title: "\$ 2.0"),
    ],
    description:
    'Be it any occasion, we all love to eat pizza at home. But, what goes behind making this delicious dish? Well, learn all about making a delicious pizza at home with this easy recipe',
    picture: "Plate-3.png",
    pictureAlt: "Plate-3-alt.png",
  ),
];
