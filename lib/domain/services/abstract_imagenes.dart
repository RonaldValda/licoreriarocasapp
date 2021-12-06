import 'dart:io';

abstract class AbstractImagenes{
  Future<dynamic> subirImagen(dynamic imagen);
  Future<File> cropCustomImage(File imageFile);
}