import 'package:flutter/material.dart';

import 'package:primera_app/styles/text_styles.dart';
import 'package:primera_app/widgets/boton_accion.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicoPage extends StatefulWidget {
  @override
  State<BasicoPage> createState() => _BasicoPageState();
}

enum SocialMedia { facebook, twitter, linkedln }

class _BasicoPageState extends State<BasicoPage> {
  final estiloTitulo = CustomTextStyles.estiloTitulo1;
  final estiloSubtitulo = CustomTextStyles.estiloSubtitulo1;
  // GoogleMapController? _controller;
  // Location currentLocation = Location();
  // Set<Marker> _markers = {};

  void tweet() async {
    // Share.share("This is Social Share twitter example",

    //     url: "https://google.com/#/hello",
    //     trailingText: "\nhello");
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(
      'Prueba',
      subject: 'Prueba',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void share(SocialMedia platform) async {
    final urls = {
      SocialMedia.facebook: ('face book shareable link'),
      SocialMedia.twitter:
          ('https://www.marca.com/futbol/real-madrid/2021/12/02/61a8aabb46163f225a8b45c6.html#'),
      SocialMedia.linkedln: ('face book linkedln link')
    };
    final url = urls[platform]!;
    await launch(url);
  }
  // void getLocation() async {
  //   var location = await currentLocation.getLocation();
  //   currentLocation.onLocationChanged.listen((LocationData loc) {
  //     _controller
  //         ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
  //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //       zoom: 12.0,
  //     )));
  //     print(loc.latitude);
  //     print(loc.longitude);
  //     setState(() {
  //       _markers.add(Marker(
  //           markerId: MarkerId('Home'),
  //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //     });
  //   });
  // }

  _llamar() async {
    try {
      if (await canLaunch('tel:+34618524332'))
        await launch('tel:+34618524332',
            enableDomStorage: true, enableJavaScript: true);
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  int max = 2;
  void _setMax() => setState(() {
        max = max == 2 ? 4 : 2;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          _buildImage(context),
          _buildTextoImagen(),
          SizedBox(
            height: 25.0,
          ),
          _buildRowAcciones(),
          _descripcion()
        ],
      ),
    ));
  }

  Widget _buildImage(context) {
    return Image(
      image: NetworkImage(
          'https://photo620x400.mnstatic.com/fab7aeb1ae26fe3866c923aeebf7cdfe/castillo-de-la-villa-de-martos.jpg'),
    );
  }

  Widget _buildTextoImagen() {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _setMax,
                child: Text(
                  'Peña de Martosasfdasdjfladsfjlñadsgadslñfhadkfbhadkñfhñkdfhadskfhkñlafdjklfajklñfjalñfjadslñfjadslñfjlñlksfjlfjlasdjfñlasjfñalsfjlñadjl',
                  style: estiloTitulo,
                  overflow: TextOverflow.ellipsis,
                  maxLines: max,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                'Preside el pueblo de martosadsjklñfjañdslfjaklsfjasljfalsjdflñasnvoiew80fjiowjfejfwlfjowjflpweflwejflwejifelijfoewjfldjfalsñfjasñlfjasñlfjaslñfdjaslñdjldsñflñasjflñasjfñasljflñadsjflñasjflñadsjflñasjflñsajlñjñ´gjkrq`gjoqgrj  qejgr`qgjq`rejg`pqgj`qagr',
                style: estiloSubtitulo,
                maxLines: max,
              )
            ],
          )),
          Icon(
            Icons.star,
            color: Colors.red,
            size: 30,
          ),
          Text(
            '41',
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    ));
  }

  Widget _buildRowAcciones() {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BotonAccion(Icons.call, 'llamar', function: _llamar),
          BotonAccion(Icons.near_me, 'Ruta', function: _llamar),
          BotonAccion(Icons.share, 'Compartir', function: tweet)
        ],
      ),
    );
  }

  Widget _descripcion() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: const Text(
        'Id lasdjfl lorem ipsumlfsjdñlfjdñaslfjñaldfjña dfañsd fjasklñf' +
            'jajsfkaslñ fjlaskñ fasñfj asdfkj aslñdfj asdlñkf asdlfkj asdlñfj adslkf asflkadsj fklñasjf adslñf',
        textAlign: TextAlign.justify,
      ),
    );
  }
}
