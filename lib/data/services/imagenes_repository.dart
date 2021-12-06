import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:licoreriarocasapp/domain/services/abstract_imagenes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImagenRepository extends AbstractImagenes{
  @override
  Future<dynamic> subirImagen(dynamic imagenFile)async{
    dynamic linkImagen;
    firebase_storage.Reference? ref;
    ref=firebase_storage.FirebaseStorage.instance.ref().child('images/${(imagenFile as File).path}');
    await ref.putFile(imagenFile).whenComplete(() async{
      await ref!.getDownloadURL().then((value) {
        linkImagen=value;
      });
    });
    return linkImagen;
  }

  @override
  Future<File> cropCustomImage(File imageFile) async{
    final file=await ImageCropper.cropImage(
    sourcePath: imageFile.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    aspectRatioPresets: [CropAspectRatioPreset.square,CropAspectRatioPreset.ratio16x9],
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: "Recortar imagén",
      toolbarColor: Colors.white,
      toolbarWidgetColor:Colors.black,
      lockAspectRatio: false
    ),
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 70,
    
    );
    AndroidUiSettings androidUiSettings()=>AndroidUiSettings(
      toolbarTitle: "Recortar imagén",
      toolbarColor: Colors.white,
      toolbarWidgetColor:Colors.black,
      lockAspectRatio: true,
    
    );
    return file!;
  }
}