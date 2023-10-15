import 'package:coffee_shop/data/model/coffee_model.dart';
import 'package:coffee_shop/ui/food_details/details.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';


navigateToDetail(CoffeeModel food, BuildContext context) {
  Navigator.push(
    context,
    PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: animation.value,
                child: FoodRecipe(
                  detail: food,
                ),
              );
            });
      },
      transitionDuration: const Duration(milliseconds: 800),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    ),
  );
}


class CustomError extends Equatable {
  final String errMsg;
  const CustomError({
    this.errMsg = '',
  });

  @override
  List<Object?> get props => [errMsg];

  @override
  bool get stringify => true;
}

enum FormStatus { initial, loading, loaded, error }
