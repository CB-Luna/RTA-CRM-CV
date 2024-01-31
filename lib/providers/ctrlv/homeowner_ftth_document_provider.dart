import 'dart:convert';
import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart' as pdfcolor;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pdfx/pdfx.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/document_info.dart';
import 'package:rta_crm_cv/models/homeowner.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;
import '../../models/company.dart';
import '../../models/crm/catalogos/model_ generic_cat.dart';

class HomeownerFTTHDocumentProvider extends ChangeNotifier {
  //Lista
  final controllerBusqueda = TextEditingController();
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  int pageRowCount = 10;
  int page = 1;
  final searchController = TextEditingController();
  bool loadingGrid = false;
  late List<PlutoGridStateManager> listStateManager;
  late DocumentInfo docInfo;

  List<Company> companyList = [Company(company: 'RTA', id: 1)];
  late String companySelectedValue;

  //PDF Formulario
  List<List<String>> data = [];
  DateTime fecha = DateTime.now();
  late DateTime duedate;
  final acountController = TextEditingController();
  final zipcodeController = TextEditingController();
  final emailController = TextEditingController();
  final representativeNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final acountNameController = TextEditingController();
  final phoneController = TextEditingController();
  final signatureTextController = TextEditingController();
  List<String> emails = [];
  bool addemail = false;
  bool ejecBloq = false;
  bool listOpenned = true;
  bool anexo = false;
  bool firmaAnexo = false;
  bool search = false;
  bool modificado = true;
  bool firmacheck = false;
  late Uint8List documento;

  late int? id;
/////////////////////////////////////////////////////////////////////////////
  clearAll() {
    listOpenned = true;
    acountController.clear();
    zipcodeController.clear();
    emailController.clear();
    representativeNameController.clear();
    addressController.clear();
    dateController.clear();
    acountNameController.clear();
    phoneController.clear();
    signatureTextController.clear();
    pdfController = null;
    companySelectedValue = '';
    emails.clear();
  }

  void selectOT(String selected) {
    companySelectedValue = selected;
    notifyListeners();
  }

  void agregarContacto() {
    const contactoVacio = '';
    emails.add(contactoVacio);
    notifyListeners();
  }

  void eliminarContacto(int index) {
    emails.removeAt(index);
    modificado = true;
    notifyListeners();
  }

  Future<void> updateState() async {
    rows.clear();
    await clearAll();
    await getHomeowner();
    return notifyListeners();
  }

  //Get User Company
  Future<void> getCompany() async {
    try {
      companyList.clear();
      for (var company in currentUser!.companies) {
        companyList.add(company);
      }
      companySelectedValue = companyList.first.company;
    } catch (e) {
      log('Error en getCompany() - $e');
    }
  }

  //Get info
  Future<void> documentInfo() async {
    try {
      String body = jsonEncode(
        {
          "apikey": "svsvs54sef5se4fsv",
          "action": "searchAccountID",
          "customerID": acountController.text,
          "firstName": "",
          "lastName": "",
          "street": "",
          "city": "",
          "state": "",
          "zipcode": "", //zipcodeController.text,
          "email": "",
          "inst": currentUser!.companies.first.company
        },
      );
      var url = Uri.parse('https://cblsrvr1.rtatel.com/planbuilder/api');
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        log((response.body));
      }
      docInfo = DocumentInfo.fromJson(response.body);
      emailController.text = docInfo.result!.first.email!;
      addressController.text = '${docInfo.result!.first.street!}${docInfo.result!.first.city!}${docInfo.result!.first.state!}';
      dateController.text = dateFormat(fecha);
      acountNameController.text = '${docInfo.result!.first.firstName!} ${docInfo.result!.first.lastName!}';
      phoneController.text = docInfo.result!.first.mobilePhone!;
      signatureTextController.text = '${docInfo.result!.first.firstName!} ${docInfo.result!.first.lastName!}';
      zipcodeController.text = currentUser!.companies.first.company;
    } catch (e) {
      search = false;
      log('Error en getInfo() - $e');
    }
    await crearPDF();
    search = true;
    notifyListeners();
  }

  Future<void> documentInfoClient(int idClient) async {
    try {
      await clearAll();
      notifyListeners();
      final res = await supabase.from('homeowner_list').select().eq('id', idClient);
      if (res == null) {
        log('Error en getHomeowner()');
        return;
      }
      List<HouseownerList> docs = (res as List<dynamic>).map((docs) => HouseownerList.fromJson(jsonEncode(docs))).toList();
      acountController.text = docs.first.formInfo!.acount!;
      zipcodeController.text = docs.first.formInfo!.zipCode!;
      emailController.text = docs.first.formInfo!.email!;
      representativeNameController.text = docs.first.formInfo!.representativeName!;
      addressController.text = docs.first.formInfo!.address!;
      acountNameController.text = docs.first.formInfo!.acountName!;
      phoneController.text = docs.first.formInfo!.phone!;
      dateController.text = docs.first.formInfo!.date!;
      signatureTextController.text = docs.first.formInfo!.acountName!;
    } catch (e) {
      log('Error en documentInfoClient() - $e');
    }
    await crearPDF();
    notifyListeners();
  }

  //Tabla Documents
  Future<void> getHomeowner() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabase.from('homeowner_list').select();
      if (res == null) {
        log('Error en getHomeowner()');
        return;
      }
      List<HouseownerList> docs = (res as List<dynamic>).map((docs) => HouseownerList.fromJson(jsonEncode(docs))).toList();

      rows.clear();
      for (HouseownerList doc in docs) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: doc.id),
              'Customer_ID': PlutoCell(value: doc.formInfo!.acount),
              'email': PlutoCell(value: doc.formInfo!.email),
              'Customer_Name': PlutoCell(value: doc.formInfo!.acountName),
              'Name_Column': PlutoCell(value: doc.document),
              'Creation_Date_Column': PlutoCell(value: dateFormat(doc.createdAt)),
              'Due_Date_Column': PlutoCell(value: dateFormat(doc.dueDate)),
              'Status_Column': PlutoCell(value: doc.idStatus),
              'Document_Column': PlutoCell(value: ''),
              'Actions_Column': PlutoCell(value: ''),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getLeads() - $e');
    }

    notifyListeners();
  }

//CRUD homeowner
  Future<bool> createHomeowner() async {
    ejecBloq = true;
    notifyListeners();
    duedate = fecha.add(const Duration(days: 5));
    try {
      final int idDoc = (await supabase.from('homeowner_list').insert(
        {
          "due_date": duedate.toString(),
          "id_status": 2,
          "form_info": {
            "acount": acountController.text,
            "zip_code": zipcodeController.text,
            "email": emailController.text,
            "email2": emails.toString(),
            "representative_name": representativeNameController.text,
            "address": addressController.text,
            "acountName": acountNameController.text,
            "phone": phoneController.text,
            "date": dateController.text,
          }
        },
      ).select())[0]['id'];

      await supabase.storage.from('homeowner').uploadBinary('$idDoc.pdf', documento);
      await supabase.from('homeowner_list').update({'document': '$idDoc.pdf'}).eq('id', idDoc);

      final token = generateToken(acountController.text, emailController.text, idDoc);

      final link = '${Uri.base.origin}$homeownerFTTHDocumentClient?token=$token';
      emails.add(emailController.text);

      await sendEmail(
        name: acountNameController.text,
        account: acountController.text,
        link: link,
        email: emails,
      );
    } catch (e) {
      log('Error en createHomeowner() - $e');
      ejecBloq = false;
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> updateDocument(int idClient) async {
    ejecBloq = true;
    notifyListeners();
    try {
      await supabase.from('homeowner_list').update(
        {
          "due_date": fecha.toString(),
          "id_status": 1,
        },
      ).eq('id', idClient);

      await supabase.storage.from('homeowner').updateBinary('$idClient.pdf', documento);
      await supabase.from('homeowner_list').update({'document': '$idClient.pdf'}).eq('id', idClient);
      //Metodo powercode
      String body = jsonEncode(
        {"apikey": "svsvs54sef5se4fsv", "action": "ftthsign_docupload", "customerID": acountController.text, "inst": zipcodeController.text, "document": "$idClient.pdf"},
      );
      var url = Uri.parse('https://apps.cblsrv42.rtatel.com/planbuilder/api'); //Produccion: Uri.parse('https://cblsrvr1.rtatel.com/planbuilder/api');
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        log((response.body));
      }
    } catch (e) {
      log('Error en createHomeowner() - $e');
      ejecBloq = false;
      notifyListeners();
      return false;
    }
    return true;
  }

  /*Future<void> getData() async {
    if (id != null) {
      var response =
          await supabasePublic.from('homeowner_ftth_document').select();
      if (response == null) {
        log('Error en getData()');
        return;
      }
      HouseownerList docs = HouseownerList.fromJson(jsonEncode(response[0]));
      acountController.text = docs.firstName;
      emailController.text = docs.lastName;
      representativeNameController.text = docs.salesStage;
      addressController.text = docs.account;
      dateController.text = docs.leadSource;
      acountNameController.text = docs.phoneNumber;
      phoneController.text = docs.expectedClose.toString();
    }

    notifyListeners();
  }*/

  Future<void> cancelDocument(int id) async {
    try {
      {
        await supabase.from('homeowner_list').update({
          'id_status': 3,
        }).eq('id', id);
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en cancelDocument() - $e');
    }
    await getHomeowner();
    notifyListeners();
  }
  /*Future<void> deleteLead() async {
    try {
      await supabaseCRM.from('leads').delete().eq('id', id);

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
    }
    await getHomeowner();
    notifyListeners();
  }*/

  //Seleccionar Documento
  FilePickerResult? docProveedor;
  PdfController? pdfController;

  Future<void> pickProveedorDoc() async {
    FilePickerResult? picker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'xml'],
    );
    //get and load pdf
    if (picker != null) {
      docProveedor = picker;
      pdfController = PdfController(
        document: PdfDocument.openData(picker.files.single.bytes!),
      );
    } else {
      pdfController = PdfController(document: PdfDocument.openAsset('assets/docs/Anexo .pdf'));
    }
    firmaAnexo = true;
    return notifyListeners();
  }

  //Descargar PDF
  String pdfUrl = '';
  void descargarArchivo(Uint8List datos, String nombreArchivo) {
    // Crear un Blob con los datos
    final blob = html.Blob([datos]);

    // Crear una URL para el Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Crear un enlace HTML para la descarga
    final anchor = html.AnchorElement(href: url)
      ..target = 'web'
      ..download = nombreArchivo;

    // Hacer clic en el enlace para iniciar la descarga
    html.document.body?.children.add(anchor);
    anchor.click();

    // Limpiar después de la descarga
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  // Firma PDF

  final SignatureController clientSignatureController = SignatureController(penColor: Colors.black, penStrokeWidth: 5);
  Uint8List? signature;
  Future<Uint8List> clientExportSignature() async {
    pdfController = null;
    notifyListeners();
    final exportController = SignatureController(penStrokeWidth: 2, penColor: Colors.black, exportBackgroundColor: Colors.white, points: clientSignatureController.points);
    signature = await exportController.toPngBytes();
    exportController.dispose();
    firmaAnexo = true;
    return signature!;
  }

  String generateToken(String account, String email, int documentId) {
    //Generar token
    final jwt = JWT(
      {
        'account': account,
        'email': email,
        'document_id': documentId,
        'creation_date': DateTime.now().toUtc().toIso8601String(),
      },
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

    // Sign it (default with HS256 algorithm)
    return jwt.sign(SecretKey('secret'));
  }

  Future<bool> sendEmail({
    required String name,
    required String account,
    required String link,
    required List<String> email,
  }) async {
    try {
      for (var email in emails) {
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "TemporaryLink",
            "subject": "Homeowner FTTH Document",
            "mailto": email,
            "variables": [
              {"name": "name", "value": name},
              {"name": "account", "value": account},
              {"name": "link", "value": link},
            ]
          },
        );
        final response = await http.post(Uri.parse(urlNotifications), headers: {'Content-Type': 'application/json'}, body: body);
        if (response.statusCode > 204) return false;
      }

      return true;
    } catch (e) {
      log('Error in sendEmail() - $e');
      return false;
    }
  }

//Creacion del PDF
  Future<PdfController?> crearPDF() async {
    pdfController = null;
    notifyListeners();
    final logo = (await rootBundle.load('assets/images/2.png')).buffer.asUint8List();
    final firma = (await rootBundle.load('assets/images/firma.png')).buffer.asUint8List();
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Row(children: [
              pw.Container(
                alignment: pw.Alignment.center,
                width: 250,
                height: 80,
                child: pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.fill),
              ),
              //Titulo
              pw.Column(children: [
                pw.Text(
                  textAlign: pw.TextAlign.center,
                  'Fiber Optic Access Agreement',
                  style: const pw.TextStyle(fontSize: 20, color: pdfcolor.PdfColor.fromInt(0XFF0A0859), decoration: pw.TextDecoration.underline),
                ),
                pw.Text(
                  'Address: ${addressController.text}',
                  style: const pw.TextStyle(
                    fontSize: 13,
                    color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
                pw.Text(
                  'Date: ${dateController.text}',
                  style: const pw.TextStyle(
                    fontSize: 13,
                    color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
            ]),

            pw.SizedBox(height: 10),
            pw.Row(children: [
              pw.Text('To Whom It May Concern:', textAlign: pw.TextAlign.start),
            ]),
            //Contenido
            pw.Text(
              'I,${acountNameController.text}, confirm that I am the owner of the property described above (the "Property"), and consent to the installation, operation, and maintenance by Rural Telecommunications of America, Inc. its affiliates, lessees, successors, and assigns (together "RTA") of RTA\'s fiber-based facilities ("Facilities") at the Property. The Facilities includes fiber optic cable, conduit, ducts, subpanels, equipment huts, and other equipment ("Facilities") to be placed within the Property and along the Property line. The Facilities will be used by RTA to provide broadband and communications services ("Service") to tenants and other occupants of the Property.',
              style: const pw.TextStyle(
                fontSize: 13,
                color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'RTA may enter the Property to areas containing the Facilities ("the Drop") to construct, repair and maintain the Drop. RTA shall design and configure the Facilities in the manner most expedient for the provision of the Service to the Property\'s tenants. RTA may disturb the ground in the Drop to the extent reasonably necessary to construct, repair, and maintain the Drop. RTA shall repair any damage to the Property caused by the installation, operation, or maintenance of RTA\'s equipment on the Property. RTA shall have no other obligation, however, to return the surface of the Drop to its original condition. RTA will terminate the Drop in the telecommunications room or other such location inside the Property.',
              style: const pw.TextStyle(
                fontSize: 13,
                color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Owner is responsible for maintenance of the surface of the Drop, including but not limited to mowing, cleaning and removing sediment, trees, shrubs and debris so that access by RTA for construction, maintenance and repair is preserved. RTA\'s obligations to install, repair or maintain the Facilities shall end if Owner impairs RTA\'s access to the Drop. At its option, RTA may remove or abandon the Facilities in place via written notice by RTA of its intent to abandon',
              style: const pw.TextStyle(
                fontSize: 13,
                color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            representativeNameController.text.isEmpty
                ? pw.Text(
                    'RTA will contact Owner, or Owner\'s designated representative, before work begins. Owner\'s designated representative is ${acountNameController.text}, the contact phone number is ${phoneController.text} and email address is ${emailController.text}. Owner\'s consent to this agreement shall continue for so long as RTA provides services to tenants or other occupants of the Property.',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  )
                : pw.Text(
                    'RTA will contact Owner, or Owner\'s designated representative, before work begins. Owner\'s designated representative is ${representativeNameController.text}, the contact phone number is ${phoneController.text} and email address is ${emailController.text}. Owner\'s consent to this agreement shall continue for so long as RTA provides services to tenants or other occupants of the Property.',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                pw.Column(children: [
                  pw.Text(
                    'Owner, Title',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                  pw.SizedBox(
                    height: 58,
                    width: 200,
                    child: pw.Center(
                      child: pw.Text(
                        'F. _______________________.',
                        style: const pw.TextStyle(
                          fontSize: 13,
                          color: pdfcolor.PdfColor.fromInt(0xFF060606),
                        ),
                      ),
                    ),
                  ),
                  pw.Text(
                    acountNameController.text,
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                ]),
                pw.Column(children: [
                  pw.Text(
                    'Accepted and Agreed to by RTA:',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                  pw.Image(
                    pw.MemoryImage(firma),
                    height: 58,
                    width: 200,
                    fit: pw.BoxFit.fill,
                    alignment: pw.Alignment.center,
                  ),
                  pw.Text(
                    'Brooke Johnson, Business Manager',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                ]),
              ]),
            )
          ],
        ),
      ),
    );
    pdf.save();
    pdfController = PdfController(
      document: PdfDocument.openData(pdf.save()),
    );
    documento = await pdf.save();
    notifyListeners();
    return pdfController;
  }

  Future<PdfController?> clientPDF() async {
    pdfController = null;
    notifyListeners();
    final logo = (await rootBundle.load('assets/images/2.png')).buffer.asUint8List();
    final firma = (await rootBundle.load('assets/images/firma.png')).buffer.asUint8List();
    final data = (await rootBundle.load("assets/fonts/Raghen-Script.ttf")).buffer.asByteData();

    final pw.Font raghenFont = pw.Font.ttf(data);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Row(children: [
              pw.Container(
                alignment: pw.Alignment.center,
                width: 250,
                height: 80,
                child: pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.fill),
              ),
              //Titulo
              pw.Column(children: [
                pw.Text(
                  textAlign: pw.TextAlign.center,
                  'Fiber Optic Access Agreement',
                  style: const pw.TextStyle(fontSize: 20, color: pdfcolor.PdfColor.fromInt(0XFF0A0859), decoration: pw.TextDecoration.underline),
                ),
                pw.Text(
                  'Address: ${addressController.text}',
                  style: const pw.TextStyle(
                    fontSize: 13,
                    color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
                pw.Text(
                  'Date: ${dateController.text}',
                  style: const pw.TextStyle(
                    fontSize: 13,
                    color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
            ]),

            pw.SizedBox(height: 10),
            pw.Row(children: [
              pw.Text('To Whom It May Concern:', textAlign: pw.TextAlign.start),
            ]),
            //Contenido
            pw.Text(
              'I,${acountNameController.text}, confirm that I am the owner of the property described above (the "Property"), and consent to the installation, operation, and maintenance by Rural Telecommunications of America, Inc. its affiliates, lessees, successors, and assigns (together "RTA") of RTA\'s fiber-based facilities ("Facilities") at the Property. The Facilities includes fiber optic cable, conduit, ducts, subpanels, equipment huts, and other equipment ("Facilities") to be placed within the Property and along the Property line. The Facilities will be used by RTA to provide broadband and communications services ("Service") to tenants and other occupants of the Property.',
              style: const pw.TextStyle(
                fontSize: 13,
                color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'RTA may enter the Property to areas containing the Facilities ("the Drop") to construct, repair and maintain the Drop. RTA shall design and configure the Facilities in the manner most expedient for the provision of the Service to the Property\'s tenants. RTA may disturb the ground in the Drop to the extent reasonably necessary to construct, repair, and maintain the Drop. RTA shall repair any damage to the Property caused by the installation, operation, or maintenance of RTA\'s equipment on the Property. RTA shall have no other obligation, however, to return the surface of the Drop to its original condition. RTA will terminate the Drop in the telecommunications room or other such location inside the Property.',
              style: const pw.TextStyle(
                fontSize: 13,
                color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Text(
              'Owner is responsible for maintenance of the surface of the Drop, including but not limited to mowing, cleaning and removing sediment, trees, shrubs and debris so that access by RTA for construction, maintenance and repair is preserved. RTA\'s obligations to install, repair or maintain the Facilities shall end if Owner impairs RTA\'s access to the Drop. At its option, RTA may remove or abandon the Facilities in place via written notice by RTA of its intent to abandon',
              style: const pw.TextStyle(
                fontSize: 13,
                color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            representativeNameController.text.isEmpty
                ? pw.Text(
                    'RTA will contact Owner, or Owner\'s designated representative, before work begins. Owner\'s designated representative is ${acountNameController.text}, the contact phone number is ${phoneController.text} and email address is ${emailController.text}. Owner\'s consent to this agreement shall continue for so long as RTA provides services to tenants or other occupants of the Property.',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  )
                : pw.Text(
                    'RTA will contact Owner, or Owner\'s designated representative, before work begins. Owner\'s designated representative is ${representativeNameController.text}, the contact phone number is ${phoneController.text} and email address is ${emailController.text}. Owner\'s consent to this agreement shall continue for so long as RTA provides services to tenants or other occupants of the Property.',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                pw.Column(children: [
                  pw.Text(
                    'Owner, Title',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                  clientSignatureController.isNotEmpty
                      ? pw.Image(
                          pw.MemoryImage(signature!),
                          height: 58,
                          width: 200,
                          fit: pw.BoxFit.fill,
                          alignment: pw.Alignment.center,
                        )
                      : pw.Container(
                          width: 200,
                          height: 58,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            firmacheck == false ? 'F. _______________________.' : signatureTextController.text,
                            textAlign: pw.TextAlign.center,
                            style: firmacheck == false
                                ? const pw.TextStyle(
                                    fontSize: 13,
                                    color: pdfcolor.PdfColor.fromInt(0xFF060606),
                                  )
                                : pw.TextStyle(fontSize: 30, font: raghenFont),
                          ),
                        ),
                  pw.Text(
                    acountNameController.text,
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                ]),
                pw.Column(children: [
                  pw.Text(
                    'Accepted and Agreed to by RTA:',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                  pw.Image(
                    pw.MemoryImage(firma),
                    height: 58,
                    width: 200,
                    fit: pw.BoxFit.fill,
                    alignment: pw.Alignment.center,
                  ),
                  pw.Text(
                    'Brooke Johnson, Business Manager',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                ]),
              ]),
            )
          ],
        ),
      ),
    );
    pdf.save();
    pdfController = PdfController(
      document: PdfDocument.openData(pdf.save()),
    );
    documento = await pdf.save();
    notifyListeners();
    return pdfController;
  }

//Seleccionar Anexo
  Future<void> pickDocument(String document) async {
    try {
      var url = supabase.storage.from('homeowner').getPublicUrl(document);
      var bodyBytes = (await http.get(Uri.parse(url))).bodyBytes;
      pdfController = PdfController(document: PdfDocument.openData(bodyBytes));
    } catch (e) {
      log('Error in pickDocument() - $e');
      return;
    }
    return;
  }

//Controladores Paginado Pluto?
  void clearControllers({bool notify = true}) {
    searchController.clear();

    if (notify) notifyListeners();
  }

  void setPageSize(String x) {
    switch (x) {
      case 'more':
        if (pageRowCount < rows.length) pageRowCount++;
        break;
      case 'less':
        if (pageRowCount > 1) pageRowCount--;
        break;
      default:
        return;
    }
    stateManager!.createFooter;
    notifyListeners();
  }

  void setPage(String x) {
    switch (x) {
      case 'next':
        if (page < stateManager!.totalPage) page++;
        break;
      case 'previous':
        if (page > 1) page--;
        break;
      case 'start':
        page = 1;
        break;
      case 'end':
        page = stateManager!.totalPage;
        break;
      default:
        return;
    }
    stateManager!.setPage(page);
    notifyListeners();
  }

  void load() {
    stateManager!.setShowLoading(true);
  }

  Future<void> selectdate(
    BuildContext context,
  ) async {
    DateTime? newDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppTheme.of(context).primaryColor, // color Appbar
                onPrimary: AppTheme.of(context).primaryBackground, // Color letras
                onSurface: AppTheme.of(context).primaryColor, // Color Meses
              ),
              dialogBackgroundColor: AppTheme.of(context).primaryBackground,
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: fecha,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (newDate == null) return;
    fecha = newDate;
    notifyListeners();
  }
}
