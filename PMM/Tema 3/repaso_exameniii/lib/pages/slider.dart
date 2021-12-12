import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _sliderValue = 20;
  void _changeSliderValue(value) => setState(() => _sliderValue = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sliders')),
        body: Column(
          children: [
            Center(),
            CustomSlider(_sliderValue, _changeSliderValue),
            animated()
          ],
        ));
  }

  Widget animated() {
    return AnimatedContainer(
      width: _sliderValue,
      height: _sliderValue,
      duration: Duration(milliseconds: 250),
      curve: Curves.linearToEaseOut,
      child: Image(
        image: NetworkImage(
            'https://static.nationalgeographic.es/files/styles/image_3200/public/11227.600x450.webp?w=710&h=533'),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  double sliderValue;
  Function(double) sliderHandler;
  CustomSlider(this.sliderValue, this.sliderHandler);
  @override
  Widget build(BuildContext context) {
    return Slider(
        divisions: 56,
        activeColor: Colors.orange,
        value: sliderValue,
        label: sliderValue.toStringAsFixed(2),
        min: 20,
        max: 400,
        onChanged: (val) => sliderHandler(val));
  }
}
