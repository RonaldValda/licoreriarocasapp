import 'dart:io';

import 'package:licoreriarocasapp/data/services/imagenes_repository.dart';

class UseCaseImagenes{
  ImagenRepository imagenRepository=ImagenRepository();
  Future<dynamic> subirImagen(dynamic imagenFile){
    return imagenRepository.subirImagen(imagenFile);
  }
  Future<File> cropCustomImage(File imageFile){
    return imagenRepository.cropCustomImage(imageFile);
  }
}