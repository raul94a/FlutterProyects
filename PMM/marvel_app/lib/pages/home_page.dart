import 'package:flutter/material.dart';
import 'package:marvel_app/character_slider.dart';
import 'package:marvel_app/constants.dart';
import 'package:marvel_app/new_character.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool horizontal = true;
  void _changeSliderView() {
    setState(() {
      if (horizontal)
        horizontal = false;
      else
        horizontal = true;
    });
  }

  void _addNewHero(String heroName, String realName, String description) {
    if (heroName.isEmpty || realName.isEmpty || description.isEmpty) return;
    setState(() {
      characterList.add({
        "hero_name": heroName,
        "real_name": realName,
        "imgUrl": 'assets/terminator.png',
        "description": description
      });
    });
  }

  void _startAddNewHero() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewCharacter(addCharacter: _addNewHero);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2 - 100,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    'assets/background1.png',
                    fit: BoxFit.fill,
                  )),
                  Positioned(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.menu,
                              size: 30,
                              color: Colors.white,
                            )),
                        Image.asset(
                          'assets/logo.png',
                          width: 100,
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30,
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  )),
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'MARVEL CHARACTERS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Get hooked on a hearty helping of heroes and villains\nfrom the humble House of Ideas!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      RaisedButton(
                          color: Colors.white,
                          onPressed: _changeSliderView,
                          child: Text(
                            '${horizontal ? "Vista vertical" : "Vista horizontal"}',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ))
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/background2.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Center(child: CharacterSlider(horizontal))
              ],
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _startAddNewHero));
  }
}
