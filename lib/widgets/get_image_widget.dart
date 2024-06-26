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
  if (image == null || image == "") {
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
  }
  return Image.asset('assets/images/default-user-profile-picture.png');
}

Widget? getAddImageU(dynamic image,
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
    return Image.asset('assets/images/fadeInAnimation.gif');
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
    return Image.asset('assets/images/fadeInAnimation.gif');
  }
}

Widget? getImageUpdate(Vehicle vehicle, dynamic newImage,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  print("------------");
  print(vehicle.image);
  if (vehicle.image == null || vehicle.image == "") {
    return Image.asset('assets/images/fadeInAnimation.gif');
  } else if (newImage is Uint8List) {
    return Image.memory(
      newImage,
      height: height,
      width: double.infinity,
      fit: boxFit,
    );
  } else if (newImage is String) {
    return Image.network(
      newImage,
      height: height,
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
  } else {
    return Image.network(
      vehicle.image!,
      height: height,
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
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

//----------     Safety Briefing
Widget? getAddImageSafetyBrifing(dynamic image,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  if (image == null) {
    return Image.asset('assets/images/fadeInAnimation.gif');
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
    return Image.asset('assets/images/fadeInAnimation.gif');
  }
}

//----------     Safety Briefing
Widget? getAddImageTraining(dynamic image,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  if (image == null) {
    return Image.asset('assets/images/fadeInAnimation.gif');
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
    return Image.asset('assets/images/fadeInAnimation.gif');
  }
}

Widget? getImageUpdateSafety(dynamic newImage,
    {double height = 180, BoxFit boxFit = BoxFit.cover}) {
  print("------------");
  print(newImage);
  if (newImage is Uint8List) {
    return Image.memory(
      newImage,
      height: height,
      width: double.infinity,
      fit: boxFit,
    );
  } else if (newImage is String) {
    return Image.network(
      newImage,
      height: height,
      width: double.infinity,
      filterQuality: FilterQuality.high,
      fit: boxFit,
    );
  }
  return null;
}
