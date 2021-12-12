import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/category_model.dart';
import '../widgets/category_container.dart';

class CategoriesPage extends StatelessWidget {
  final List<Category> _categories = DUMMY_CATEGORIES;

  @override
  Widget build(BuildContext context) {
    bool? fromDrawer =
        ModalRoute.of(context)!.settings.arguments != null ? true : false;

    if (!fromDrawer) return _buildGridView();
    //si venimos del drawer...
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
      ),
      body: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return GridView(
        padding: EdgeInsets.all(15),
        children: [
          ..._categories
              .map((e) => CategoryContainer(e.id!, e.title!, e.color))
              .toList()
        ],
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200));
  }
}
