import 'package:flutter/material.dart';
import 'package:youtube_diegoveloper_challenges/coffee_concept/coffee.dart';

const _initialPage = 8.0;

enum CoffeeSizes { S, M, B }

class CoffeeBLoC {
  final pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );
  final pageTextController = PageController(initialPage: _initialPage.toInt());
  final currentPage = ValueNotifier<double?>(_initialPage);
  final textPage = ValueNotifier<double?>(_initialPage);
  final _size = ValueNotifier<double>(1);
  ValueNotifier<double> get coffeSize => _size;
  final _isCold = ValueNotifier<bool>(false);
  ValueNotifier<bool> get isCold => _isCold;
  final _coffeeSize = ValueNotifier<CoffeeSizes>(CoffeeSizes.B);
  ValueNotifier<CoffeeSizes> get coffeeSize => _coffeeSize;
  Coffee? _coffee;
  Coffee? get coffee => _coffee;

  void init() {
    currentPage.value = _initialPage;
    textPage.value = _initialPage;
    pageCoffeeController.addListener(_coffeeScrollListener);
    pageTextController.addListener(_textScrollListener);
  }

  void initDetails() {
    _coffeeSize.value = CoffeeSizes.B;
    _size.value = 1.0;
    _isCold.value = false;
  }

  void _coffeeScrollListener() {
    currentPage.value = pageCoffeeController.page;
  }

  void getSizeCoffee(CoffeeSizes size) {
    if (size == CoffeeSizes.S) _size.value = .8;
    if (size == CoffeeSizes.M) _size.value = .9;
    if (size == CoffeeSizes.B) _size.value = 1.0;
    _coffeeSize.value = size;
  }

  void setTemperature(bool value) => _isCold.value = value;

  void _textScrollListener() {
    textPage.value = pageTextController.page;
  }

  void setCoffe(Coffee coffee) => _coffee = coffee;

  void dispose() {
    pageCoffeeController.removeListener(_coffeeScrollListener);
    pageTextController.removeListener(_textScrollListener);
    pageCoffeeController.dispose();
    pageTextController.dispose();
  }
}

class CoffeeProvider extends InheritedWidget {
  final CoffeeBLoC bloc;

  const CoffeeProvider({required this.bloc, required Widget child})
      : super(child: child);

  static CoffeeProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();

  @override
  bool updateShouldNotify(covariant CoffeeProvider oldWidget) => false;
}
