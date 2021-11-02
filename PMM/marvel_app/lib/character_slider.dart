import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:marvel_app/character_page.dart';
import 'constants.dart';

class CharacterSlider extends StatefulWidget {
  @override
  bool horizontal;
  CharacterSlider(this.horizontal);
  _CharacterSliderState createState() => _CharacterSliderState();
}

class _CharacterSliderState extends State<CharacterSlider> {
  @override
  Widget build(BuildContext context) {
    return slider.CarouselSlider.builder(
      itemCount: characterList.length,
      itemBuilder: (context, int itemIndex, int pageViewIndex) =>
          CharacterCard(itemIndex, widget.horizontal),
      options: slider.CarouselOptions(
          scrollDirection: widget.horizontal ? Axis.horizontal : Axis.vertical,
          viewportFraction: 0.5,
          height: widget.horizontal ? 340 : 540,
          enlargeCenterPage: true),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final index;
  final horizontal;
  CharacterCard(this.index, this.horizontal);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CharacterPage(index)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(40),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  child: Hero(
                    tag: characterList[index]['imgUrl'] as String,
                    child: Image.asset(characterList[index]['imgUrl'] as String,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Container(
                height: 5,
                color: Colors.red,
                width: MediaQuery.of(context).size.width / 2 - 50,
              ),
              Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          characterList[index]['hero_name']!.toUpperCase()
                              as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          characterList[index]['real_name']!.toUpperCase()
                              as String,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
