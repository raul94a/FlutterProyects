import 'package:flutter/material.dart';

class NewCharacter extends StatefulWidget {
  Function(String, String, String) addCharacter;
  NewCharacter({required this.addCharacter});

  @override
  State<NewCharacter> createState() => _NewCharacterState();
}

class _NewCharacterState extends State<NewCharacter> {
  final heroNameController = TextEditingController();

  final realNameController = TextEditingController();

  final urlImageController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 8,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(label: Text('Hero name')),
              controller: heroNameController,
            ),
            TextField(
                decoration: InputDecoration(label: Text('Real name')),
                controller: realNameController),
            TextField(
                decoration: InputDecoration(label: Text('Description')),
                controller: descriptionController),
            Center(
                child: RaisedButton(
              color: Colors.black,
              child: Text(
                'Add character',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                widget.addCharacter(heroNameController.text,
                    realNameController.text, descriptionController.text);
                Navigator.of(context).pop();
              },
            ))
          ],
        ),
      ),
    );
  }
}
