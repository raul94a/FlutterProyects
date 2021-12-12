import 'package:flutter/material.dart';

class CardItemImage extends StatelessWidget {
  const CardItemImage({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: FadeInImage(
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/img/loading2.gif'),
              image: NetworkImage(
                imageUrl,
              ),
            )),
        Positioned(
          bottom: 20,
          right: 0,
          child: Container(
            width: 300,
            color: Colors.black54,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(title,
                style: TextStyle(color: Colors.white, fontSize: 26),
                softWrap: true,
                overflow: TextOverflow.fade),
          ),
        ),
      ],
    );
  }
}
