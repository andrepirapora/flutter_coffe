import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_diegoveloper_challenges/coffee_concept/coffee_bloc.dart';

const _duration = Duration(milliseconds: 600);

class CoffeeConceptDetails extends StatefulWidget {
  const CoffeeConceptDetails({Key? key}) : super(key: key);

  @override
  _CoffeeConceptDetailsState createState() => _CoffeeConceptDetailsState();
}

class _CoffeeConceptDetailsState extends State<CoffeeConceptDetails> {
  @override
  void initState() {
    CoffeeProvider.of(context)!.bloc.initDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(height: 30);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(icon: const Icon(Icons.shopping_bag_outlined), onPressed: () {})
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Name(),
          separator,
          const ContCoffe(),
          SafeArea(
            top: false,
            child: TweenAnimationBuilder<double>(
              duration: _duration,
              tween: Tween(begin: 1.0, end: 0.0),
              child: Column(
                children: const [
                  separator,
                  CoffeeSizesWidget(),
                  separator,
                  Temperature()
                ],
              ),
              builder: (_, value, child) => Transform.translate(
                  offset: Offset(0, value * 250), child: child),
            ),
          ),
        ],
      ),
    );
  }
}

class ContCoffe extends StatelessWidget {
  const ContCoffe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: const [
          Ice(),
          ImageCoffee(),
          Price(),
          ButtonAdd(),
        ],
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * .15, vertical: 25),
        child: TweenAnimationBuilder<double>(
          duration: _duration,
          tween: Tween(begin: 1.0, end: 0.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 20),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.brown, size: 30),
          ),
          builder: (_, value, child) {
            return Transform.translate(
              offset: Offset(value * 200, 0),
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final coffee = CoffeeProvider.of(context)!.bloc.coffee!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
      child: Hero(
        tag: 'text_${coffee.name}',
        child: Material(
          color: Colors.transparent,
          child: Text(
            coffee.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class Price extends StatelessWidget {
  const Price({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final coffee = CoffeeProvider.of(context)!.bloc.coffee!;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(left: size.width * .1),
        child: TweenAnimationBuilder<double>(
          duration: _duration,
          tween: Tween(begin: 1.0, end: 0.0),
          builder: (context, value, child) => Transform.translate(
              offset: Offset(-100 * value, 240 * value), child: child),
          child: Text(
            '\$${coffee.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
              shadows: [
                BoxShadow(
                    color: Colors.black45, blurRadius: 40, spreadRadius: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageCoffee extends StatelessWidget {
  const ImageCoffee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CoffeeProvider.of(context)!.bloc;
    final coffee = bloc.coffee!;
    return ValueListenableBuilder<double>(
      valueListenable: bloc.coffeSize,
      child: Hero(
        tag: coffee.name,
        child: Image.asset(coffee.image, fit: BoxFit.fitHeight),
      ),
      builder: (_, value, child) => TweenAnimationBuilder<double>(
        duration: _duration,
        curve: Curves.elasticOut,
        tween: Tween(begin: 1.0, end: value),
        child: ValueListenableBuilder<bool>(
          valueListenable: bloc.isCold,
          builder: (_, value, __) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              child!,
              if (value)
                ShaderMask(
                  shaderCallback: (Rect bounds) => LinearGradient(
                    colors: [
                      Colors.blueAccent.withOpacity(.2),
                      Colors.blueAccent.withOpacity(.2),
                    ],
                  ).createShader(bounds),
                  child: Image.asset(
                    coffee.image,
                    fit: BoxFit.fitHeight,
                  ),
                ),
            ],
          ),
        ),
        builder: (_, scale, child) => Transform.scale(
            alignment: Alignment.bottomCenter, scale: scale, child: child),
      ),
    );
  }
}

class Ice extends StatelessWidget {
  const Ice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = CoffeeProvider.of(context)!.bloc;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: ValueListenableBuilder<bool>(
          valueListenable: bloc.isCold,
          child: Image.asset('assets/coffee_concept/ice.png',
              width: size.width * .3),
          builder: (_, value, child) => TweenAnimationBuilder<double>(
            duration: _duration,
            curve: Curves.easeInOut,
            tween: value
                ? Tween(begin: 0.0, end: 135)
                : Tween(end: 0.0, begin: 135),
            child: child,
            builder: (_, value, child) =>
                Transform.translate(offset: Offset(value, 0), child: child),
          ),
        ),
      ),
    );
  }
}

class CoffeeSizesWidget extends StatelessWidget {
  const CoffeeSizesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CoffeeProvider.of(context)!.bloc;
    return ValueListenableBuilder<CoffeeSizes>(
      valueListenable: bloc.coffeeSize,
      builder: (_, value, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CoffeeSize(
              asset: 'assets/coffee_concept/taza_s.png',
              isSelected: value == CoffeeSizes.S,
              name: 'S',
              onPressed: () => bloc.getSizeCoffee(CoffeeSizes.S),
              height: 25,
            ),
            const SizedBox(width: 10),
            CoffeeSize(
              asset: 'assets/coffee_concept/taza_m.png',
              isSelected: value == CoffeeSizes.M,
              name: 'M',
              onPressed: () => bloc.getSizeCoffee(CoffeeSizes.M),
              height: 35,
            ),
            const SizedBox(width: 10),
            CoffeeSize(
              asset: 'assets/coffee_concept/taza_l.png',
              isSelected: value == CoffeeSizes.B,
              name: 'B',
              onPressed: () => bloc.getSizeCoffee(CoffeeSizes.B),
              height: 45,
            ),
          ],
        );
      },
    );
  }
}

class CoffeeSize extends StatelessWidget {
  const CoffeeSize({
    Key? key,
    this.onPressed,
    this.asset,
    this.name,
    this.isSelected,
    this.height,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String? asset;
  final String? name;
  final bool? isSelected;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      pressedOpacity: .9,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(
            asset!,
            color: isSelected! ? Colors.brown : Colors.brown.withOpacity(.4),
            height: height,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            name!,
            style: TextStyle(
              fontSize: 22,
              color: isSelected! ? Colors.brown : Colors.brown.withOpacity(.4),
            ),
          ),
        ],
      ),
    );
  }
}

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = CoffeeProvider.of(context)!.bloc;
    return ValueListenableBuilder<bool>(
      valueListenable: bloc.isCold,
      builder: (_, value, __) {
        return Row(
          children: [
            ItemTemperature(
              text: 'Hot | Warm',
              isSelected: !value,
              onTap: () =>
                  CoffeeProvider.of(context)!.bloc.setTemperature(false),
            ),
            Container(width: 1.5, color: Colors.black.withOpacity(.1)),
            ItemTemperature(
              text: 'Cold | Ice',
              isSelected: value,
              onTap: () =>
                  CoffeeProvider.of(context)!.bloc.setTemperature(true),
            ),
          ],
        );
      },
    );
  }
}

class ItemTemperature extends StatelessWidget {
  const ItemTemperature({
    Key? key,
    this.text,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  final String? text;
  final bool? isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              if (isSelected!)
                BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 1.5)
            ],
          ),
          child: Text(
            text!,
            style: TextStyle(
              fontSize: 22,
              color: isSelected! ? Colors.brown : Colors.brown.withOpacity(.4),
            ),
          ),
        ),
      ),
    );
  }
}
