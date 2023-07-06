import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/vehicle.dart';

Widget? getImage(String? image, {double height = 180}) {
  if (image == null) {
    return null;
  } else if (image.startsWith('http') || image.startsWith('https')) {
    return FadeInImage(
      height: 180,
      width: double.infinity,
      placeholder: const AssetImage('assets/images/animation_500_l3ur8tqa.gif'),
      image: NetworkImage(image),
      fit: BoxFit.cover,
    );
  }
  return Image.file(
    File(image),
    height: height,
    width: double.infinity,
    fit: BoxFit.cover,
  );
}

Widget? getUserImage(dynamic image,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  if (image == null) {
    return Image.asset('assets/images/default-user-profile-picture.png');
  } else if (image is Uint8List) {
    return Image.memory(
      image,
      height: height,
      width: double.infinity,
      fit: boxFit,
    );
  } else if (image is String) {
    return Image.network(
      image,
      height: height,
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
  } else {
    return Image.asset('assets/images/default-user-profile-picture.png');
  }
}

//---------------------------------------------
Widget? getAddImageV(dynamic image,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  if (image == null) {
    return Image.asset('assets/images/default-user-profile-picture.png');
  } else if (image is Uint8List) {
    return Image.memory(
      image,
      height: height,
      width: double.infinity,
      fit: boxFit,
    );
  } else if (image is String) {
    return Image.network(
      image,
      height: height,
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
  } else {
    return Image.asset('assets/images/default-user-profile-picture.png');
  }
}

Widget? getImageUpdate(dynamic image, Vehicle vehicle,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  if (image == null) {
    print("ENTRO AQUI NO HAY IMAGEN");
    print(image);
    return Image.network(vehicle.image!);
  } else if (image is Uint8List) {
    print("ENTRO AQUI Uint8LIST");

    return Image.memory(
      image,
      height: height,
      width: double.infinity,
      fit: boxFit,
    );
  } else if (image is String?) {
    print("ENTRO AQUI STRING");
    print(image);

    return Image.network(
      image!,
      height: height,
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
  } else {
    return Image.asset(vehicle.image!);
  }
}

Image getNullableImage(
  String? image, {
  double? height,
  BoxFit boxFit = BoxFit.cover,
  String bucket = 'avatars',
}) {
  if (image != null) {
    final res = supabase.storage.from(bucket).getPublicUrl(image);
    return Image(
      image: NetworkImage(res),
      height: height,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
  }
  return Image(
    image: const AssetImage('assets/images/default-user-profile-picture.png'),
    height: height,
    filterQuality: FilterQuality.high,
    fit: boxFit,
  );
}
