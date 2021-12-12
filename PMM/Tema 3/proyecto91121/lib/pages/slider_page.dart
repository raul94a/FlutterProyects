import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliderPage extends StatefulWidget {
  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _valorSlider = 100.0;
  bool _blockcheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kjladsfjlñadsnfñ'),
      ),
      body: Column(
        children: [_crearSlider(), _crearImagen(), _crearSwitch()],
      ),
    );
  }

  Widget _crearSlider() {
    return Slider(
      value: _valorSlider,
      max: 400.0,
      min: 10.0,
      activeColor: Colors.indigoAccent,
      label: _valorSlider.toStringAsFixed(0),
      divisions: 20,
      onChanged: (valor) {
        if (!_blockcheck) {
          setState(() {
            _valorSlider = valor;
          });
        }
      },
    );
  }

  Widget _crearImagen() {
    return AnimatedContainer(
      width: _valorSlider,
      duration: Duration(milliseconds: 200),
      child: Image(
        width: _valorSlider,
        image: NetworkImage(
            'https://cdn.download.ams.birds.cornell.edu/api/v1/asset/56896311/900'),
      ),
    );
  }

  Widget _crearCheckbox() {
    return CheckboxListTile(
        title: Text('Bloquear slider'),
        value: _blockcheck,
        onChanged: (valor) {
          setState(() {
            _blockcheck = valor!;
          });
        });
  }

  Widget _crearSwitch() {
    return SwitchListTile(
        title: Text('Bloquear slider'),
        value: _blockcheck,
        onChanged: (valor) {
          setState(() {
            _blockcheck = valor;
          });
        });
  }
}
