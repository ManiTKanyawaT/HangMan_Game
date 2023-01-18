import 'package:flutter/material.dart';
import 'package:hang_man/widgets/letter.dart';
import 'colors.dart';
import 'widgets/figure_images.dart';
import 'utilities/game.dart';
import 'widgets/letter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String word = 'PANWAD';
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: const Text(
          'Hangman Game',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh_outlined,
                size: 30,
              ))
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, 'assets/hang.png'),
                figureImage(Game.tries >= 1, 'assets/head.png'),
                figureImage(Game.tries >= 2, 'assets/body.png'),
                figureImage(Game.tries >= 3, 'assets/ra.png'),
                figureImage(Game.tries >= 4, 'assets/la.png'),
                figureImage(Game.tries >= 5, 'assets/rl.png'),
                figureImage(Game.tries >= 6, 'assets/ll.png'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...word
                  .split(
                    '',
                  )
                  .map((e) => letter(e.toUpperCase(),
                      !Game.selectedChar.contains(e.toUpperCase())))
                  .toList(),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 250,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              padding: const EdgeInsets.all(8),
              children: [
                ...alphabets.map((e) {
                  return RawMaterialButton(
                    onPressed: Game.selectedChar.contains(e)
                        ? null
                        : () {
                            setState(() {
                              Game.selectedChar.add(e);
                              (Game.selectedChar);
                              if (!word.split('').contains(e.toUpperCase())) {
                                Game.tries++;
                              }
                            });
                          },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    fillColor: Game.selectedChar.contains(e)
                        ? Colors.blueGrey
                        : Colors.lightBlue,
                    child: Text(
                      e,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
