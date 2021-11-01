import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Storage {
  //primero tengo que tener una referencia a la ruta donde se almacenarán mis datos
  Future<String> localPath() async =>
      await getApplicationDocumentsDirectory().then((dir) => dir.path);

  Future<File> localFile() async {
    final path = await localPath();
    File file = File('$path/data.TX');
    if (!await file.exists()) {
      //print('El archivo no existe y ha sido creado');
      await file.create();
    }
    return file;
  }

  Future<String> readFile() async {
    try {
      final file = await localFile();
      return await file.readAsString();
    } catch (e) {
      rethrow;
    }
  }

  Future<File> writeFile(String transactions) async =>
      await localFile().then((value) => value.writeAsString(transactions));
}
