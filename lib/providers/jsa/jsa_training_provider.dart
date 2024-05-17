// ignore_for_file: library_prefixes, unnecessary_null_comparison

import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdfx/pdfx.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/jsa/team_members.dart';
import 'package:rta_crm_cv/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseFlutter;

import 'jsa_provider.dart';

class JsaTrainingProvider extends ChangeNotifier {
  // Controllers
  final searchController = TextEditingController();
  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final creationDateController = TextEditingController();
  final expirationDateController = TextEditingController();
  final companyController = TextEditingController();

  TeamMembersSafetyModel? teamMember;
  User? membersSelection;
  List<User> users = [];

  // PDF Values
  FilePickerResult? docProveedorPDF;
  PdfController? pdfControllerPDF;
  DateTime today = DateTime.now();
  String? tiempo = '';
  Uint8List? documento;
  User? selectedUser;

  // Images Values
  FilePickerResult? docProveedor;
  PdfController? pdfController;
  Uint8List? imageBytes;
  String? placeHolderImage;
  String? imageUrl;
  String? imageName;
  String? imageUrlUpdate;
  Uint8List? webImage;
  Uint8List? webImageClear;
  int? idActualProblem;

  void selectUser(String id) async {
    // selectedUser = user;
    selectedUser =
        users.firstWhere((user) => user.id == id, orElse: () => users[0]);

    notifyListeners();
  }

  Future<void> getListUsers(String company) async {
    try {
      // selectedUser = null;

      final res = await supabase
          .from('users')
          .select()
          .eq('company->>company', company);
      if (res == null) {
        print('Error en getDocumentList()');
        return;
      }
      users = (res as List<dynamic>)
          .map((usuario) => User.fromMap(usuario))
          .toList();
      users = users
          .where((user) => user.roles.any((role) =>
              role.application == currentUser!.currentRole.application))
          .toList();
      // Se supone que esto filtra por el id 26 que es el technician jsa
      users = users
          .where((user) => user.roles.any((role) => role.id == 26))
          .toList();

      // print("En getInformationJSA con el JSA_FK: con res: $res");
    } catch (e) {
      print('Error en getListUsers() - $e');
    }
    notifyListeners();
  }

  static Future<Uint8List?> selectDocumentPDF() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return null;

      // Accede a los bytes del archivo seleccionado
      final bytes = result.files.single.bytes;
      if (bytes == null) return null;

      // Convierte los bytes a un Uint8List (Lista de enteros sin signo de 8 bits)

      print("bytes: $bytes");
      return Uint8List.fromList(bytes);
    } catch (e) {
      print('Error al seleccionar el archivo: $e');
    }
    return null;
  }

  Future<bool> selectImage() async {
    final ImagePicker picker = ImagePicker();

    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    webImage = await pickedImage?.readAsBytes();

    if (pickedImage != null) {
      if (await pickedImage.length() <= 1000000) {
        notifyListeners();
        placeHolderImage = "${uuid.v4()}${pickedImage.name}";

        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void deleteFile() {
    docProveedorPDF = null;
    pdfControllerPDF = null;
    webImage = null;
    pdfController = null;
    notifyListeners();
  }

  Future<bool> uploadImage(int idTraining) async {
    try {
      final storageResponse =
          await supabase.storage.from('jsa/training').uploadBinary(
                placeHolderImage!,
                webImage!,
                fileOptions: const supabaseFlutter.FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      if (storageResponse.isNotEmpty) {
        imageUrl = supabase.storage.from('jsa/training').getPublicUrl(
              placeHolderImage!,
            );

        await supabaseJsa
            .from('training_document')
            .update({'doc_name': '$imageUrl'}).eq("id_training", idTraining);
      }

      return true;
    } catch (e) {
      log('Error in uploadImage() - $e');
      return false;
      // return null;
    }
  }

  // Subir Documento
  Future<bool> uploadDocument(int seqId, int idTraining) async {
    // ejecBloq = true;s
    // notifyListeners();
    today = DateTime.now();
    tiempo =
        '${today.year}-${(today.month)}-${(today.day)}_${(today.hour)}:${(today.minute)}:${(today.second)}';
    try {
      if (documento == null) {
        print("El documento es nulo");
        return false;
      }
//se sube el documento
      await supabase.storage
          .from('jsa/training')
          .uploadBinary('${tiempo}_$seqId.pdf', documento!);

      await supabaseJsa.from('training_document').update(
          {'doc_name': '${tiempo}_$seqId.pdf'}).eq("id_training", idTraining);

      print("subida correcta a Supabase");
    } catch (e) {
      log('Error en uploadDocument() - $e');
      // ejecBloq = false;
      // notifyListeners();
      return false;
    }

    return true;
  }

  // Future<void> pickDoc() async {
  //   FilePickerResult? picker = await FilePickerWeb.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
  //   //get and load pdf
  //   if (picker != null) {
  //     docProveedor = picker;
  //     imageBytes = picker.files.single.bytes;
  //   } else {
  //     imageBytes = null;
  //   }
  //   notifyListeners();
  //   return;
  // }

  Future<void> pickProveedorDoc() async {
    FilePickerResult? picker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'xml'],
    );
    //get and load pdf
    if (picker != null) {
      docProveedorPDF = picker;
      documento = picker.files.single.bytes;
      pdfControllerPDF = PdfController(
        document: PdfDocument.openData(picker.files.single.bytes!),
      );
      // documento = pdfControllerPDF.openData()
    }

    return notifyListeners();
  }

  Future<supabaseFlutter.PostgrestList> createTrainingAdmin() async {
    Map<String, dynamic> mainDataAdmin = {
      'title': titleController.text,
      'creation_date': creationDateController.text,
      'expiration_date': expirationDateController.text,
      'user_fk': selectedUser!.id,
      'id_status': 1,
    };
    //  Map<String, dynamic> mainData = {
    //   'title': titleController.text,
    //   'creation_date': creationDateController.text,
    //   'expiration_date': expirationDateController.text,
    //   'user_fk': currentUser!.id,
    //   'id_status': 1,
    // };
    final response = await supabaseJsa
        .from('training_document')
        .insert(mainDataAdmin)
        .select<supabaseFlutter.PostgrestList>('id_training');

    if (response == null) {
      print('Error inserting MAIN data: ${response.toString()}');
    } else {
      print('MAIN Data inserted successfully!');
    }
    notifyListeners();

    return response;
  }

  Future<supabaseFlutter.PostgrestList> createTrainingUser() async {
    Map<String, dynamic> mainData = {
      'title': titleController.text,
      'creation_date': creationDateController.text,
      'expiration_date': expirationDateController.text,
      'user_fk': currentUser!.id,
      'id_status': 1,
    };
    final response = await supabaseJsa
        .from('training_document')
        .insert(mainData)
        .select<supabaseFlutter.PostgrestList>('id_training');

    if (response == null) {
      print('Error inserting MAIN data: ${response.toString()}');
    } else {
      print('MAIN Data inserted successfully!');
    }
    notifyListeners();

    return response;
  }

  clearAll() {
    imageBytes = null;
    placeHolderImage = null;
    webImage = null;
    docProveedorPDF = null;
    pdfControllerPDF = null;
    selectedUser = null;
    titleController.clear();
    creationDateController.clear();
    expirationDateController.clear();
  }
}
