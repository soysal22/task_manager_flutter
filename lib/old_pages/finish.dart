// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, unrelated_type_equality_checks

import 'package:card_flick/models/card__model.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

List<CardModel> cardModelImagesList = [
  CardModel(
    id: 0,
    imageUrl: 'assets/images/majorarcana/death.jpg',
    title: "death",
  ),
  CardModel(
    id: 1,
    imageUrl: 'assets/images/majorarcana/hangedman.jpg',
    title: "hangedman",
  ),
  CardModel(
    id: 2,
    imageUrl: 'assets/images/majorarcana/judgement.jpg',
    title: "judgement",
  ),
  CardModel(
    id: 3,
    imageUrl: 'assets/images/majorarcana/justice.jpg',
    title: "justice",
  ),
  CardModel(
    id: 4,
    imageUrl: 'assets/images/majorarcana/strength.jpg',
    title: "strength",
  ),
  CardModel(
    id: 5,
    imageUrl: 'assets/images/majorarcana/temperance.jpg',
    title: "temperance",
  ),
  CardModel(
    id: 6,
    imageUrl: 'assets/images/majorarcana/thechariot.jpg',
    title: "thechariot",
  ),
  CardModel(
    id: 7,
    imageUrl: 'assets/images/majorarcana/thedevil.jpg',
    title: "thedevil",
  ),
  CardModel(
    id: 8,
    imageUrl: 'assets/images/majorarcana/theemperor.jpg',
    title: "theemperor",
  ),
  CardModel(
    id: 9,
    imageUrl: 'assets/images/majorarcana/theempress.jpg',
    title: "theempress",
  ),
  CardModel(
    id: 10,
    imageUrl: 'assets/images/majorarcana/thefool.jpg',
    title: "thefool",
  ),
  CardModel(
    id: 11,
    imageUrl: 'assets/images/majorarcana/thehermit.jpg',
    title: "thehermit",
  ),
  CardModel(
    id: 12,
    imageUrl: 'assets/images/majorarcana/thehierophant.jpg',
    title: "thehierophant",
  ),
  CardModel(
    id: 13,
    imageUrl: 'assets/images/majorarcana/thehighpriest.jpg',
    title: "thehighpriest",
  ),
  CardModel(
    id: 14,
    imageUrl: 'assets/images/majorarcana/thelovers.jpg',
    title: "thelovers",
  ),
  CardModel(
    id: 15,
    imageUrl: 'assets/images/majorarcana/themagician.jpg',
    title: "themagician",
  ),
  CardModel(
    id: 16,
    imageUrl: '',
    title: "themoon",
  ),
  CardModel(
    id: 17,
    imageUrl: 'assets/images/majorarcana/thestar.jpg',
    title: "thestar",
  ),
  CardModel(
    id: 18,
    imageUrl: 'assets/images/majorarcana/thesun.jpg',
    title: "thesun",
  ),
  CardModel(
    id: 19,
    imageUrl: 'assets/images/majorarcana/thetower.jpg',
    title: "thetower",
  ),
  CardModel(
    id: 20,
    imageUrl: 'assets/images/majorarcana/theworld.jpg',
    title: "theworld",
  ),
  CardModel(
    id: 21,
    imageUrl: 'assets/images/majorarcana/wheloffortune.jpg',
    title: "wheloffortune",
  ),
];

class _ChatState extends State<Chat> {
  @override
  void initState() {
    cardModelImagesList.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatButton(context),
      backgroundColor: const Color.fromARGB(255, 159, 56, 1),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: cardModelImagesList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 50,
                height: 80,
                child: FlipCard(
                  onFlipDone: (isFront) {
                    if (isFront) {
                      _customShowDialog(context, index);
                      Future.delayed(const Duration(seconds: 1))
                          .then((value) => Navigator.of(context).pop());
                    }
                  },
                  fill: Fill.fillBack,
                  front: _closeImage(),
                  back: comeToImage(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> _customShowDialog(BuildContext context, int index) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(cardModelImagesList[index].title ?? "title",
              textAlign: TextAlign.center),
          content: CircleAvatar(
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                  )),
            ),
          ),
        );
      },
    );
  }

  Container comeToImage(int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 0, 58),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(cardModelImagesList[index].imageUrl ?? "empty"),
        ),
      ),
    );
  }

  Container _closeImage() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 0, 58),
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/back.png'),
        ),
      ),
    );
  }

  FloatingActionButton _floatButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
        Future.delayed(const Duration(seconds: 2)).then((value) =>
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Chat())));
      },
      child: const Icon(Icons.refresh),
    );
  }
}
