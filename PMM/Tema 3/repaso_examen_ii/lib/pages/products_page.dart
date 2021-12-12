import 'package:flutter/material.dart';
import 'package:repaso_examen_ii/config/config.dart';
import 'package:repaso_examen_ii/providers/products_provider.dart';
import 'package:repaso_examen_ii/providers/users_provider.dart';

class ProductsPage extends StatefulWidget {
  // List<Map<String, dynamic>>? routes;
  //ProductsPage([this.routes]);
  final fonts;
  final titles;
  ProductsPage(this.fonts, this.titles);
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  //variable que controla CUANTOS productos vamos a ir cargando cn el scroll. Aumentará de 10 en 10
  int _initLimit = 0;
  int _limit = 10;
  bool stopFuture = false;
  void futureStopped() => setState(() {
        stopFuture = true;
      });
  var prods = [];
  void addProducts(List data) {
    setState(() {
      prods.addAll((data).map((e) => e));
    });
  }

  List<Map<String, dynamic>> routes = [];
  //filtramos por ruta perteneciente a tabBar
  List<Map<String, dynamic>> _tabBarRoutes() {
    return routes.where((element) => element['tabBar'] == '1').toList();
  }

  List<Widget> _createTabs() {
    return _tabBarRoutes()
        .map((e) => Tab(
              icon: IconButton(
                  onPressed: () => Navigator.pushNamed(context, e['nombre'],
                      arguments: routes),
                  icon: Icon(icons[e['icono']])),
            ))
        .toList();
  }

  ScrollController controlador = ScrollController();
  double position = 0;
  //primera peticion a la rest api
  void getProducts() async {
    var p = await ProductsProvider.productsByRange(_initLimit, _limit)
        .then((v) => v as List);
    addProductsToProds(p);
  }

  //añadir productos a la list apara hacer el scrolll infinito
  void addProductsToProds(List p) {
    setState(() {
      prods.addAll(p.map((e) => e));
      _initLimit += 10;
      _limit += 10;
    });
  }

  void initState() {
    super.initState();
    //getProducts nos proporcionara la primera petición a codeigniter, es decir, nos devolverá los primeros 10 productos
    getProducts();
    //for (var i = 0; i < p.length; i++) prods.add(p[i]);
    controlador.addListener(() async {
      if (controlador.position.pixels == controlador.position.maxScrollExtent) {
        print('ESTO ABAJOOOOO: $_limit');
        var p = await ProductsProvider.productsByRange(_initLimit, _limit);
        // setState(() {
        //   _initLimit += 10;
        //   _limit += 10;
        //   // prods = [];
        //   for (var i = 0; i < p.length; i++) {
        //     prods.add(p[i]);
        //   }
        // });
        addProductsToProds(p);
        print(prods);
      }
    });
  }

  Widget build(BuildContext context) {
    List<Map<String, dynamic>> AppRoutes = ModalRoute.of(context)!
        .settings
        .arguments as List<Map<String, dynamic>>;
    setState(() {
      routes = AppRoutes;
    });

    dynamic existsAddProductRoute() {
      bool exists = false;
      AppRoutes.forEach((element) {
        if (element['nombre'] == 'add-product') {
          exists = true;
        }
      });
      return exists;
    }

    print(existsAddProductRoute());
    return DefaultTabController(
      initialIndex: 0,
      length: _tabBarRoutes().length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.titles[1]['texto']! as String),
          bottom: TabBar(
            tabs: [..._createTabs()],
          ),
        ),
        body: Center(child: _ProductsList(prods, controlador, widget.fonts)),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            List<dynamic> users = await UsersProvider.getAll();
            if (existsAddProductRoute()) {
              Navigator.pushNamed(context, 'add-product', arguments: users);
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ProductBuilder extends StatelessWidget {
  int init;
  int limit;
  ScrollController controlador;
  final fonts;
  ProductBuilder(this.init, this.limit, this.controlador, this.fonts);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductsProvider.productsByRange(init, limit),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return _ProductsList(snapshot.data, controlador, fonts);
        }
      },
    );
  }
}

class _ProductsList extends StatefulWidget {
  ScrollController controlador;
  List<dynamic> products;
  final fonts;
  _ProductsList(this.products, this.controlador, this.fonts);

  @override
  State<_ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<_ProductsList> {
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: widget.controlador,
        itemCount: widget.products.length,
        itemBuilder: (BuildContext context, index) {
          return _ProductContainer(widget.products, index, widget.fonts);
        });
  }
}

class _ProductContainer extends StatelessWidget {
  final products;
  final index;
  final fonts;
  _ProductContainer(this.products, this.index, this.fonts);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'products/product',
              arguments: products[index]);
        },
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(50, 15),
                  bottomLeft: Radius.elliptical(50, 105),
                  topLeft: Radius.elliptical(50, 15),
                  bottomRight: Radius.elliptical(50, 105)),
              side: BorderSide(color: Colors.black)),
          margin: const EdgeInsets.only(top: 5, bottom: 15),
          color: Colors.grey,
          elevation: 10,
          child: Column(
            children: [
              //foto
              FadeInImage(
                placeholder: const AssetImage('assets/cat.gif'),
                image: NetworkImage(
                  products[index]['img'],
                ),
              ),

              //nombre
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    products[index]['nombre'],
                    style: TextStyle(fontSize: fonts[0]['size'] +0.1),
                  )),
              //precio
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('${products[index]['precio']} €',
                    style: TextStyle(fontSize: fonts[1]['size'] + 0.1)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
