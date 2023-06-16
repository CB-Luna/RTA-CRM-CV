// To parse this JSON data, do
//
//     final issues = issuesFromMap(jsonString);

import 'dart:convert';

class Issues {
  final int idVehicle;
  final int issuesR;
  final int? issuesD;
  final int idBucketInspectionRFk;
  final int? idBucketInspectionDFk;
  final BucketInspection bucketInspectionR;
  final BucketInspection bucketInspectionD;
  final int idCarBodyworkRFk;
  final CarBodywork carBodyworkR;
  final int? idCarBodyworkDFk;
  final CarBodywork carBodyworkD;
  final int idEquipmentRFk;
  final Equiment equimentR;
  final int? idEquipmentDFk;
  final Equiment equimentD;
  final String idUserFk;
  final UserProfile userProfile;
  final int idExtraRFk;
  final Extra extraR;
  final int? idExtraDFk;
  final Extra extraD;
  final int idFluidsCheckRFk;
  final FluidCheck fluidCheckR;
  final int? idFluidsCheckDFk;
  final FluidCheck fluidCheckD;
  final int idLightsRFk;
  final Lights lightsR;
  final int? idLightsDFk;
  final Lights lightsD;
  final int idMeasureRFk;
  final Measure measureR;
  final int? idMeasureDFk;
  final Measure measureD;
  final int idSecurityRFk;
  final Security securityR;
  final int? idSecurityDFk;
  final Security securityD;

  Issues({
    required this.idVehicle,
    required this.issuesR,
    this.issuesD,
    required this.idBucketInspectionRFk,
    this.idBucketInspectionDFk,
    required this.bucketInspectionR,
    required this.bucketInspectionD,
    required this.idCarBodyworkRFk,
    required this.carBodyworkR,
    this.idCarBodyworkDFk,
    required this.carBodyworkD,
    required this.idEquipmentRFk,
    required this.equimentR,
    this.idEquipmentDFk,
    required this.equimentD,
    required this.idUserFk,
    required this.userProfile,
    required this.idExtraRFk,
    required this.extraR,
    this.idExtraDFk,
    required this.extraD,
    required this.idFluidsCheckRFk,
    required this.fluidCheckR,
    this.idFluidsCheckDFk,
    required this.fluidCheckD,
    required this.idLightsRFk,
    required this.lightsR,
    this.idLightsDFk,
    required this.lightsD,
    required this.idMeasureRFk,
    required this.measureR,
    this.idMeasureDFk,
    required this.measureD,
    required this.idSecurityRFk,
    required this.securityR,
    this.idSecurityDFk,
    required this.securityD,
  });

  factory Issues.fromJson(String str) => Issues.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Issues.fromMap(Map<String, dynamic> json) => Issues(
        idVehicle: json["id_vehicle"],
        issuesR: json["issues_r"],
        issuesD: json["issues_d"],
        idBucketInspectionRFk: json["id_bucket_inspection_r_fk"],
        idBucketInspectionDFk: json["id_bucket_inspection_d_fk"],
        bucketInspectionR:
            BucketInspection.fromMap(json["bucket_inspection_r"]),
        bucketInspectionD:
            BucketInspection.fromMap(json["bucket_inspection_d"]),
        idCarBodyworkRFk: json["id_car_bodywork_r_fk"],
        carBodyworkR: CarBodywork.fromMap(json["car_bodywork_r"]),
        idCarBodyworkDFk: json["id_car_bodywork_d_fk"],
        carBodyworkD: CarBodywork.fromMap(json["car_bodywork_d"]),
        idEquipmentRFk: json["id_equipment_r_fk"],
        equimentR: Equiment.fromMap(json["equiment_r"]),
        idEquipmentDFk: json["id_equipment_d_fk"],
        equimentD: Equiment.fromMap(json["equiment_d"]),
        idUserFk: json["id_user_fk"],
        userProfile: UserProfile.fromMap(json["user_profile"]),
        idExtraRFk: json["id_extra_r_fk"],
        extraR: Extra.fromMap(json["extra_r"]),
        idExtraDFk: json["id_extra_d_fk"],
        extraD: Extra.fromMap(json["extra_d"]),
        idFluidsCheckRFk: json["id_fluids_check_r_fk"],
        fluidCheckR: FluidCheck.fromMap(json["fluid_check_r"]),
        idFluidsCheckDFk: json["id_fluids_check_d_fk"],
        fluidCheckD: FluidCheck.fromMap(json["fluid_check_d"]),
        idLightsRFk: json["id_lights_r_fk"],
        lightsR: Lights.fromMap(json["lights_r"]),
        idLightsDFk: json["id_lights_d_fk"],
        lightsD: Lights.fromMap(json["lights_d"]),
        idMeasureRFk: json["id_measure_r_fk"],
        measureR: Measure.fromMap(json["measure_r"]),
        idMeasureDFk: json["id_measure_d_fk"],
        measureD: Measure.fromMap(json["measure_d"]),
        idSecurityRFk: json["id_security_r_fk"],
        securityR: Security.fromMap(json["security_r"]),
        idSecurityDFk: json["id_security_d_fk"],
        securityD: Security.fromMap(json["security_d"]),
      );

  Map<String, dynamic> toMap() => {
        "id_vehicle": idVehicle,
        "issues_r": issuesR,
        "issues_d": issuesD,
        "id_bucket_inspection_r_fk": idBucketInspectionRFk,
        "id_bucket_inspection_d_fk": idBucketInspectionDFk,
        "bucket_inspection_r": bucketInspectionR.toMap(),
        "bucket_inspection_d": bucketInspectionD.toMap(),
        "id_car_bodywork_r_fk": idCarBodyworkRFk,
        "car_bodywork_r": carBodyworkR.toMap(),
        "id_car_bodywork_d_fk": idCarBodyworkDFk,
        "car_bodywork_d": carBodyworkD.toMap(),
        "id_equipment_r_fk": idEquipmentRFk,
        "equiment_r": equimentR.toMap(),
        "id_equipment_d_fk": idEquipmentDFk,
        "equiment_d": equimentD.toMap(),
        "id_user_fk": idUserFk,
        "user_profile": userProfile.toMap(),
        "id_extra_r_fk": idExtraRFk,
        "extra_r": extraR.toMap(),
        "id_extra_d_fk": idExtraDFk,
        "extra_d": extraD.toMap(),
        "id_fluids_check_r_fk": idFluidsCheckRFk,
        "fluid_check_r": fluidCheckR.toMap(),
        "id_fluids_check_d_fk": idFluidsCheckDFk,
        "fluid_check_d": fluidCheckD.toMap(),
        "id_lights_r_fk": idLightsRFk,
        "lights_r": lightsR.toMap(),
        "id_lights_d_fk": idLightsDFk,
        "lights_d": lightsD.toMap(),
        "id_measure_r_fk": idMeasureRFk,
        "measure_r": measureR.toMap(),
        "id_measure_d_fk": idMeasureDFk,
        "measure_d": measureD.toMap(),
        "id_security_r_fk": idSecurityRFk,
        "security_r": securityR.toMap(),
        "id_security_d_fk": idSecurityDFk,
        "security_d": securityD.toMap(),
      };
}

class BucketInspection {
  final int? idBucketInspection;
  final BucketLiner? insulated;
  final String? insulatedComments;
  final String? insulatedImage;
  final BucketLiner? holesDrilled;
  final Comments? holesDrilledComments;
  final String? holesDrilledImage;
  final BucketLiner? bucketLiner;
  final Comments? bucketLinerComments;
  final String? bucketLinerImage;
  final DateTime? dateAdded;

  BucketInspection({
    this.idBucketInspection,
    this.insulated,
    this.insulatedComments,
    this.insulatedImage,
    this.holesDrilled,
    this.holesDrilledComments,
    this.holesDrilledImage,
    this.bucketLiner,
    this.bucketLinerComments,
    this.bucketLinerImage,
    this.dateAdded,
  });

  factory BucketInspection.fromJson(String str) =>
      BucketInspection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BucketInspection.fromMap(Map<String, dynamic> json) =>
      BucketInspection(
        idBucketInspection: json["id_bucket_inspection"],
        insulated: bucketLinerValues.map[json["insulated"]]!,
        insulatedComments: json["insulated_comments"],
        insulatedImage: json["insulated_image"],
        holesDrilled: bucketLinerValues.map[json["holes_drilled"]]!,
        holesDrilledComments:
            commentsValues.map[json["holes_drilled_comments"]]!,
        holesDrilledImage: json["holes_drilled_image"],
        bucketLiner: bucketLinerValues.map[json["bucket_liner"]]!,
        bucketLinerComments: commentsValues.map[json["bucket_liner_comments"]]!,
        bucketLinerImage: json["bucket_liner_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_bucket_inspection": idBucketInspection,
        "insulated": bucketLinerValues.reverse[insulated],
        "insulated_comments": insulatedComments,
        "insulated_image": insulatedImage,
        "holes_drilled": bucketLinerValues.reverse[holesDrilled],
        "holes_drilled_comments": commentsValues.reverse[holesDrilledComments],
        "holes_drilled_image": holesDrilledImage,
        "bucket_liner": bucketLinerValues.reverse[bucketLiner],
        "bucket_liner_comments": commentsValues.reverse[bucketLinerComments],
        "bucket_liner_image": bucketLinerImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

enum BucketLiner { GOOD, BAD }

final bucketLinerValues =
    EnumValues({"Bad": BucketLiner.BAD, "Good": BucketLiner.GOOD});

enum Comments { EMPTY, BAD, NO, NONE, NORMA }

final commentsValues = EnumValues({
  "Bad": Comments.BAD,
  "": Comments.EMPTY,
  "No": Comments.NO,
  "None": Comments.NONE,
  "Norma": Comments.NORMA
});

class CarBodywork {
  final int? idCarBodyworkD;
  final BucketLiner? wiperBladesFront;
  final Comments? wiperBladesFrontComments;
  final String? wiperBladesFrontImage;
  final BucketLiner? wiperBladesBack;
  final Comments? wiperBladesBackComments;
  final String? wiperBladesBackImage;
  final BucketLiner? windshieldWiperFront;
  final BucketLiner? windshieldWiperBack;
  final BucketLiner? generalBody;
  final Comments? generalBodyComments;
  final String? generalBodyImage;
  final BucketLiner? decaling;
  final String? decalingComments;
  final dynamic decalingImage;
  final BucketLiner? tires;
  final String? tiresComments;
  final dynamic tiresImage;
  final BucketLiner? glass;
  final Comments? glassComments;
  final String? glassImage;
  final BucketLiner? mirrors;
  final MirrorsComments? mirrorsComments;
  final String? mirrorsImage;
  final BucketLiner? parking;
  final ParkingComments? parkingComments;
  final String? parkingImage;
  final BucketLiner? brakes;
  final String? brakesComments;
  final dynamic brakesImage;
  final BucketLiner? emgBrakes;
  final String? emgBrakesComments;
  final dynamic emgBrakesImage;
  final BucketLiner? horn;
  final Comments? hornComments;
  final String? hornImage;
  final DateTime? dateAdded;
  final int? idCarBodywork;

  CarBodywork({
    this.idCarBodyworkD,
    this.wiperBladesFront,
    this.wiperBladesFrontComments,
    this.wiperBladesFrontImage,
    this.wiperBladesBack,
    this.wiperBladesBackComments,
    this.wiperBladesBackImage,
    this.windshieldWiperFront,
    this.windshieldWiperBack,
    this.generalBody,
    this.generalBodyComments,
    this.generalBodyImage,
    this.decaling,
    this.decalingComments,
    this.decalingImage,
    this.tires,
    this.tiresComments,
    this.tiresImage,
    this.glass,
    this.glassComments,
    this.glassImage,
    this.mirrors,
    this.mirrorsComments,
    this.mirrorsImage,
    this.parking,
    this.parkingComments,
    this.parkingImage,
    this.brakes,
    this.brakesComments,
    this.brakesImage,
    this.emgBrakes,
    this.emgBrakesComments,
    this.emgBrakesImage,
    this.horn,
    this.hornComments,
    this.hornImage,
    this.dateAdded,
    this.idCarBodywork,
  });

  factory CarBodywork.fromJson(String str) =>
      CarBodywork.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarBodywork.fromMap(Map<String, dynamic> json) => CarBodywork(
        idCarBodyworkD: json["id_car_bodywork_d"],
        wiperBladesFront: bucketLinerValues.map[json["wiper_blades_front"]]!,
        wiperBladesFrontComments:
            commentsValues.map[json["wiper_blades_front_comments"]]!,
        wiperBladesFrontImage: json["wiper_blades_front_image"],
        wiperBladesBack: bucketLinerValues.map[json["wiper_blades_back"]]!,
        wiperBladesBackComments:
            commentsValues.map[json["wiper_blades_back_comments"]]!,
        wiperBladesBackImage: json["wiper_blades_back_image"],
        windshieldWiperFront:
            bucketLinerValues.map[json["windshield_wiper_front"]]!,
        windshieldWiperBack:
            bucketLinerValues.map[json["windshield_wiper_back"]]!,
        generalBody: bucketLinerValues.map[json["general_body"]]!,
        generalBodyComments: commentsValues.map[json["general_body_comments"]]!,
        generalBodyImage: json["general_body_image"],
        decaling: bucketLinerValues.map[json["decaling"]]!,
        decalingComments: json["decaling_comments"],
        decalingImage: json["decaling_image"],
        tires: bucketLinerValues.map[json["tires"]]!,
        tiresComments: json["tires_comments"],
        tiresImage: json["tires_image"],
        glass: bucketLinerValues.map[json["glass"]]!,
        glassComments: commentsValues.map[json["glass_comments"]]!,
        glassImage: json["glass_image"],
        mirrors: bucketLinerValues.map[json["mirrors"]]!,
        mirrorsComments: mirrorsCommentsValues.map[json["mirrors_comments"]]!,
        mirrorsImage: json["mirrors_image"],
        parking: bucketLinerValues.map[json["parking"]]!,
        parkingComments: parkingCommentsValues.map[json["parking_comments"]]!,
        parkingImage: json["parking_image"],
        brakes: bucketLinerValues.map[json["brakes"]]!,
        brakesComments: json["brakes_comments"],
        brakesImage: json["brakes_image"],
        emgBrakes: bucketLinerValues.map[json["emg_brakes"]]!,
        emgBrakesComments: json["emg_brakes_comments"],
        emgBrakesImage: json["emg_brakes_image"],
        horn: bucketLinerValues.map[json["horn"]]!,
        hornComments: commentsValues.map[json["horn_comments"]]!,
        hornImage: json["horn_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
        idCarBodywork: json["id_car_bodywork"],
      );

  Map<String, dynamic> toMap() => {
        "id_car_bodywork_d": idCarBodyworkD,
        "wiper_blades_front": bucketLinerValues.reverse[wiperBladesFront],
        "wiper_blades_front_comments":
            commentsValues.reverse[wiperBladesFrontComments],
        "wiper_blades_front_image": wiperBladesFrontImage,
        "wiper_blades_back": bucketLinerValues.reverse[wiperBladesBack],
        "wiper_blades_back_comments":
            commentsValues.reverse[wiperBladesBackComments],
        "wiper_blades_back_image": wiperBladesBackImage,
        "windshield_wiper_front":
            bucketLinerValues.reverse[windshieldWiperFront],
        "windshield_wiper_back": bucketLinerValues.reverse[windshieldWiperBack],
        "general_body": bucketLinerValues.reverse[generalBody],
        "general_body_comments": commentsValues.reverse[generalBodyComments],
        "general_body_image": generalBodyImage,
        "decaling": bucketLinerValues.reverse[decaling],
        "decaling_comments": decalingComments,
        "decaling_image": decalingImage,
        "tires": bucketLinerValues.reverse[tires],
        "tires_comments": tiresComments,
        "tires_image": tiresImage,
        "glass": bucketLinerValues.reverse[glass],
        "glass_comments": commentsValues.reverse[glassComments],
        "glass_image": glassImage,
        "mirrors": bucketLinerValues.reverse[mirrors],
        "mirrors_comments": mirrorsCommentsValues.reverse[mirrorsComments],
        "mirrors_image": mirrorsImage,
        "parking": bucketLinerValues.reverse[parking],
        "parking_comments": parkingCommentsValues.reverse[parkingComments],
        "parking_image": parkingImage,
        "brakes": bucketLinerValues.reverse[brakes],
        "brakes_comments": brakesComments,
        "brakes_image": brakesImage,
        "emg_brakes": bucketLinerValues.reverse[emgBrakes],
        "emg_brakes_comments": emgBrakesComments,
        "emg_brakes_image": emgBrakesImage,
        "horn": bucketLinerValues.reverse[horn],
        "horn_comments": commentsValues.reverse[hornComments],
        "horn_image": hornImage,
        "date_added": dateAdded?.toIso8601String(),
        "id_car_bodywork": idCarBodywork,
      };
}

enum MirrorsComments { EMPTY, MORROS_UN_BAD_STATE }

final mirrorsCommentsValues = EnumValues({
  "": MirrorsComments.EMPTY,
  "Morros un Bad state": MirrorsComments.MORROS_UN_BAD_STATE
});

enum ParkingComments { EMPTY, BAD }

final parkingCommentsValues =
    EnumValues({"Bad ": ParkingComments.BAD, "": ParkingComments.EMPTY});

class Equiment {
  final int? idEquipment;
  final BinsBoxKey? ignitionKey;
  final IgnitionKeyComments? ignitionKeyComments;
  final String? ignitionKeyImage;
  final BinsBoxKey? binsBoxKey;
  final Comments? binsBoxKeyComments;
  final String? binsBoxKeyImage;
  final BinsBoxKey? vehicleRegistrationCopy;
  final VehicleCopyComments? vehicleRegistrationCopyComments;
  final String? vehicleRegistrationCopyImage;
  final BinsBoxKey? vehicleInsuranceCopy;
  final VehicleCopyComments? vehicleInsuranceCopyComments;
  final String? vehicleInsuranceCopyImage;
  final BinsBoxKey? bucketLiftOperatorManual;
  final Comments? bucketLiftOperatorManualComments;
  final String? bucketLiftOperatorManualImage;
  final DateTime? dateAdded;

  Equiment({
    this.idEquipment,
    this.ignitionKey,
    this.ignitionKeyComments,
    this.ignitionKeyImage,
    this.binsBoxKey,
    this.binsBoxKeyComments,
    this.binsBoxKeyImage,
    this.vehicleRegistrationCopy,
    this.vehicleRegistrationCopyComments,
    this.vehicleRegistrationCopyImage,
    this.vehicleInsuranceCopy,
    this.vehicleInsuranceCopyComments,
    this.vehicleInsuranceCopyImage,
    this.bucketLiftOperatorManual,
    this.bucketLiftOperatorManualComments,
    this.bucketLiftOperatorManualImage,
    this.dateAdded,
  });

  factory Equiment.fromJson(String str) => Equiment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Equiment.fromMap(Map<String, dynamic> json) => Equiment(
        idEquipment: json["id_equipment"],
        ignitionKey: binsBoxKeyValues.map[json["ignition_key"]]!,
        ignitionKeyComments:
            ignitionKeyCommentsValues.map[json["ignition_key_comments"]]!,
        ignitionKeyImage: json["ignition_key_image"],
        binsBoxKey: binsBoxKeyValues.map[json["bins_box_key"]]!,
        binsBoxKeyComments: commentsValues.map[json["bins_box_key_comments"]]!,
        binsBoxKeyImage: json["bins_box_key_image"],
        vehicleRegistrationCopy:
            binsBoxKeyValues.map[json["vehicle_registration_copy"]]!,
        vehicleRegistrationCopyComments: vehicleCopyCommentsValues
            .map[json["vehicle_registration_copy_comments"]]!,
        vehicleRegistrationCopyImage: json["vehicle_registration_copy_image"],
        vehicleInsuranceCopy:
            binsBoxKeyValues.map[json["vehicle_insurance_copy"]]!,
        vehicleInsuranceCopyComments: vehicleCopyCommentsValues
            .map[json["vehicle_insurance_copy_comments"]]!,
        vehicleInsuranceCopyImage: json["vehicle_insurance_copy_image"],
        bucketLiftOperatorManual:
            binsBoxKeyValues.map[json["bucket_lift_operator_manual"]]!,
        bucketLiftOperatorManualComments:
            commentsValues.map[json["bucket_lift_operator_manual_comments"]]!,
        bucketLiftOperatorManualImage:
            json["bucket_lift_operator_manual_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_equipment": idEquipment,
        "ignition_key": binsBoxKeyValues.reverse[ignitionKey],
        "ignition_key_comments":
            ignitionKeyCommentsValues.reverse[ignitionKeyComments],
        "ignition_key_image": ignitionKeyImage,
        "bins_box_key": binsBoxKeyValues.reverse[binsBoxKey],
        "bins_box_key_comments": commentsValues.reverse[binsBoxKeyComments],
        "bins_box_key_image": binsBoxKeyImage,
        "vehicle_registration_copy":
            binsBoxKeyValues.reverse[vehicleRegistrationCopy],
        "vehicle_registration_copy_comments":
            vehicleCopyCommentsValues.reverse[vehicleRegistrationCopyComments],
        "vehicle_registration_copy_image": vehicleRegistrationCopyImage,
        "vehicle_insurance_copy":
            binsBoxKeyValues.reverse[vehicleInsuranceCopy],
        "vehicle_insurance_copy_comments":
            vehicleCopyCommentsValues.reverse[vehicleInsuranceCopyComments],
        "vehicle_insurance_copy_image": vehicleInsuranceCopyImage,
        "bucket_lift_operator_manual":
            binsBoxKeyValues.reverse[bucketLiftOperatorManual],
        "bucket_lift_operator_manual_comments":
            commentsValues.reverse[bucketLiftOperatorManualComments],
        "bucket_lift_operator_manual_image": bucketLiftOperatorManualImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

enum BinsBoxKey { YES, NO }

final binsBoxKeyValues =
    EnumValues({"No": BinsBoxKey.NO, "Yes": BinsBoxKey.YES});

enum IgnitionKeyComments {
  EMPTY,
  NONE,
  I_DID_NOT_HAVE_THE_IGNITION_KEY,
  BAD,
  NONE_ELEMENT
}

final ignitionKeyCommentsValues = EnumValues({
  "Bad": IgnitionKeyComments.BAD,
  "": IgnitionKeyComments.EMPTY,
  "I did not have the ignition key":
      IgnitionKeyComments.I_DID_NOT_HAVE_THE_IGNITION_KEY,
  "None": IgnitionKeyComments.NONE,
  "None element": IgnitionKeyComments.NONE_ELEMENT
});

enum VehicleCopyComments { EMPTY, NOEM, NONE }

final vehicleCopyCommentsValues = EnumValues({
  "": VehicleCopyComments.EMPTY,
  "Noem": VehicleCopyComments.NOEM,
  "None": VehicleCopyComments.NONE
});

class Extra {
  final int? idExtra;
  final BucketLiner? ladder;
  final Comments? ladderComments;
  final String? ladderImage;
  final BucketLiner? stepLadder;
  final Comments? stepLadderComments;
  final String? stepLadderImage;
  final BucketLiner? ladderStraps;
  final LadderStrapsComments? ladderStrapsComments;
  final String? ladderStrapsImage;
  final BucketLiner? hydraulicFluidForBucket;
  final String? hydraulicFluidForBucketComments;
  final dynamic hydraulicFluidForBucketImage;
  final BucketLiner? fiberReelRack;
  final Comments? fiberReelRackComments;
  final String? fiberReelRackImage;
  final BucketLiner? binsLockedAndSecure;
  final String? binsLockedAndSecureComments;
  final dynamic binsLockedAndSecureImage;
  final BucketLiner? safetyHarness;
  final String? safetyHarnessComments;
  final dynamic safetyHarnessImage;
  final BucketLiner? lanyardSafetyHarness;
  final Comments? lanyardSafetyHarnessComments;
  final String? lanyardSafetyHarnessImage;
  final DateTime? dateAdded;

  Extra({
    this.idExtra,
    this.ladder,
    this.ladderComments,
    this.ladderImage,
    this.stepLadder,
    this.stepLadderComments,
    this.stepLadderImage,
    this.ladderStraps,
    this.ladderStrapsComments,
    this.ladderStrapsImage,
    this.hydraulicFluidForBucket,
    this.hydraulicFluidForBucketComments,
    this.hydraulicFluidForBucketImage,
    this.fiberReelRack,
    this.fiberReelRackComments,
    this.fiberReelRackImage,
    this.binsLockedAndSecure,
    this.binsLockedAndSecureComments,
    this.binsLockedAndSecureImage,
    this.safetyHarness,
    this.safetyHarnessComments,
    this.safetyHarnessImage,
    this.lanyardSafetyHarness,
    this.lanyardSafetyHarnessComments,
    this.lanyardSafetyHarnessImage,
    this.dateAdded,
  });

  factory Extra.fromJson(String str) => Extra.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Extra.fromMap(Map<String, dynamic> json) => Extra(
        idExtra: json["id_extra"],
        ladder: bucketLinerValues.map[json["ladder"]]!,
        ladderComments: commentsValues.map[json["ladder_comments"]]!,
        ladderImage: json["ladder_image"],
        stepLadder: bucketLinerValues.map[json["step_ladder"]]!,
        stepLadderComments: commentsValues.map[json["step_ladder_comments"]]!,
        stepLadderImage: json["step_ladder_image"],
        ladderStraps: bucketLinerValues.map[json["ladder_straps"]]!,
        ladderStrapsComments:
            ladderStrapsCommentsValues.map[json["ladder_straps_comments"]]!,
        ladderStrapsImage: json["ladder_straps_image"],
        hydraulicFluidForBucket:
            bucketLinerValues.map[json["hydraulic_fluid_for_bucket"]]!,
        hydraulicFluidForBucketComments:
            json["hydraulic_fluid_for_bucket_comments"],
        hydraulicFluidForBucketImage: json["hydraulic_fluid_for_bucket_image"],
        fiberReelRack: bucketLinerValues.map[json["fiber_reel_rack"]]!,
        fiberReelRackComments:
            commentsValues.map[json["fiber_reel_rack_comments"]]!,
        fiberReelRackImage: json["fiber_reel_rack_image"],
        binsLockedAndSecure:
            bucketLinerValues.map[json["bins_locked_and_secure"]]!,
        binsLockedAndSecureComments: json["bins_locked_and_secure_comments"],
        binsLockedAndSecureImage: json["bins_locked_and_secure_image"],
        safetyHarness: bucketLinerValues.map[json["safety_harness"]]!,
        safetyHarnessComments: json["safety_harness_comments"],
        safetyHarnessImage: json["safety_harness_image"],
        lanyardSafetyHarness:
            bucketLinerValues.map[json["lanyard_safety_harness"]]!,
        lanyardSafetyHarnessComments:
            commentsValues.map[json["lanyard_safety_harness_comments"]]!,
        lanyardSafetyHarnessImage: json["lanyard_safety_harness_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_extra": idExtra,
        "ladder": bucketLinerValues.reverse[ladder],
        "ladder_comments": commentsValues.reverse[ladderComments],
        "ladder_image": ladderImage,
        "step_ladder": bucketLinerValues.reverse[stepLadder],
        "step_ladder_comments": commentsValues.reverse[stepLadderComments],
        "step_ladder_image": stepLadderImage,
        "ladder_straps": bucketLinerValues.reverse[ladderStraps],
        "ladder_straps_comments":
            ladderStrapsCommentsValues.reverse[ladderStrapsComments],
        "ladder_straps_image": ladderStrapsImage,
        "hydraulic_fluid_for_bucket":
            bucketLinerValues.reverse[hydraulicFluidForBucket],
        "hydraulic_fluid_for_bucket_comments": hydraulicFluidForBucketComments,
        "hydraulic_fluid_for_bucket_image": hydraulicFluidForBucketImage,
        "fiber_reel_rack": bucketLinerValues.reverse[fiberReelRack],
        "fiber_reel_rack_comments":
            commentsValues.reverse[fiberReelRackComments],
        "fiber_reel_rack_image": fiberReelRackImage,
        "bins_locked_and_secure":
            bucketLinerValues.reverse[binsLockedAndSecure],
        "bins_locked_and_secure_comments": binsLockedAndSecureComments,
        "bins_locked_and_secure_image": binsLockedAndSecureImage,
        "safety_harness": bucketLinerValues.reverse[safetyHarness],
        "safety_harness_comments": safetyHarnessComments,
        "safety_harness_image": safetyHarnessImage,
        "lanyard_safety_harness":
            bucketLinerValues.reverse[lanyardSafetyHarness],
        "lanyard_safety_harness_comments":
            commentsValues.reverse[lanyardSafetyHarnessComments],
        "lanyard_safety_harness_image": lanyardSafetyHarnessImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

enum LadderStrapsComments { EMPTY, BAD_STATE, BAD, NAD, BAS }

final ladderStrapsCommentsValues = EnumValues({
  "Bad": LadderStrapsComments.BAD,
  "Bad state": LadderStrapsComments.BAD_STATE,
  "Bas": LadderStrapsComments.BAS,
  "": LadderStrapsComments.EMPTY,
  "Nad": LadderStrapsComments.NAD
});

class FluidCheck {
  final int? idFluidsCheck;
  final BucketLiner? engineOil;
  final LadderStrapsComments? engineOilComments;
  final String? engineOilImage;
  final BucketLiner? transmission;
  final LadderStrapsComments? transmissionComments;
  final String? transmissionImage;
  final BucketLiner? coolant;
  final Comments? coolantComments;
  final String? coolantImage;
  final BucketLiner? powerSteering;
  final String? powerSteeringComments;
  final dynamic powerSteeringImage;
  final BucketLiner? dieselExhaustFluid;
  final String? dieselExhaustFluidComments;
  final dynamic dieselExhaustFluidImage;
  final BucketLiner? windshieldWasherFluid;
  final WindshieldWasherFluidComments? windshieldWasherFluidComments;
  final String? windshieldWasherFluidImage;
  final DateTime? dateAdded;

  FluidCheck({
    this.idFluidsCheck,
    this.engineOil,
    this.engineOilComments,
    this.engineOilImage,
    this.transmission,
    this.transmissionComments,
    this.transmissionImage,
    this.coolant,
    this.coolantComments,
    this.coolantImage,
    this.powerSteering,
    this.powerSteeringComments,
    this.powerSteeringImage,
    this.dieselExhaustFluid,
    this.dieselExhaustFluidComments,
    this.dieselExhaustFluidImage,
    this.windshieldWasherFluid,
    this.windshieldWasherFluidComments,
    this.windshieldWasherFluidImage,
    this.dateAdded,
  });

  factory FluidCheck.fromJson(String str) =>
      FluidCheck.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluidCheck.fromMap(Map<String, dynamic> json) => FluidCheck(
        idFluidsCheck: json["id_fluids_check"],
        engineOil: bucketLinerValues.map[json["engine_oil"]]!,
        engineOilComments:
            ladderStrapsCommentsValues.map[json["engine_oil_comments"]]!,
        engineOilImage: json["engine_oil_image"],
        transmission: bucketLinerValues.map[json["transmission"]]!,
        transmissionComments:
            ladderStrapsCommentsValues.map[json["transmission_comments"]]!,
        transmissionImage: json["transmission_image"],
        coolant: bucketLinerValues.map[json["coolant"]]!,
        coolantComments: commentsValues.map[json["coolant_comments"]]!,
        coolantImage: json["coolant_image"],
        powerSteering: bucketLinerValues.map[json["power_steering"]]!,
        powerSteeringComments: json["power_steering_comments"],
        powerSteeringImage: json["power_steering_image"],
        dieselExhaustFluid:
            bucketLinerValues.map[json["diesel_exhaust_fluid"]]!,
        dieselExhaustFluidComments: json["diesel_exhaust_fluid_comments"],
        dieselExhaustFluidImage: json["diesel_exhaust_fluid_image"],
        windshieldWasherFluid:
            bucketLinerValues.map[json["windshield_washer_fluid"]]!,
        windshieldWasherFluidComments: windshieldWasherFluidCommentsValues
            .map[json["windshield_washer_fluid_comments"]]!,
        windshieldWasherFluidImage: json["windshield_washer_fluid_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_fluids_check": idFluidsCheck,
        "engine_oil": bucketLinerValues.reverse[engineOil],
        "engine_oil_comments":
            ladderStrapsCommentsValues.reverse[engineOilComments],
        "engine_oil_image": engineOilImage,
        "transmission": bucketLinerValues.reverse[transmission],
        "transmission_comments":
            ladderStrapsCommentsValues.reverse[transmissionComments],
        "transmission_image": transmissionImage,
        "coolant": bucketLinerValues.reverse[coolant],
        "coolant_comments": commentsValues.reverse[coolantComments],
        "coolant_image": coolantImage,
        "power_steering": bucketLinerValues.reverse[powerSteering],
        "power_steering_comments": powerSteeringComments,
        "power_steering_image": powerSteeringImage,
        "diesel_exhaust_fluid": bucketLinerValues.reverse[dieselExhaustFluid],
        "diesel_exhaust_fluid_comments": dieselExhaustFluidComments,
        "diesel_exhaust_fluid_image": dieselExhaustFluidImage,
        "windshield_washer_fluid":
            bucketLinerValues.reverse[windshieldWasherFluid],
        "windshield_washer_fluid_comments": windshieldWasherFluidCommentsValues
            .reverse[windshieldWasherFluidComments],
        "windshield_washer_fluid_image": windshieldWasherFluidImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

enum WindshieldWasherFluidComments { EMPTY, FLUID_IN_BAD_STATE, BAD }

final windshieldWasherFluidCommentsValues = EnumValues({
  "Bad": WindshieldWasherFluidComments.BAD,
  "": WindshieldWasherFluidComments.EMPTY,
  "Fluid in Bad state": WindshieldWasherFluidComments.FLUID_IN_BAD_STATE
});

class Lights {
  final int? idLights;
  final BucketLiner? headlights;
  final LadderStrapsComments? headlightsComments;
  final String? headlightsImage;
  final BucketLiner? brakeLights;
  final Comments? brakeLightsComments;
  final String? brakeLightsImage;
  final BucketLiner? reverseLights;
  final String? reverseLightsComments;
  final dynamic reverseLightsImage;
  final BucketLiner? warningLights;
  final LadderStrapsComments? warningLightsComments;
  final String? warningLightsImage;
  final BucketLiner? turnSignals;
  final LadderStrapsComments? turnSignalsComments;
  final String? turnSignalsImage;
  final BucketLiner? the4WayFlashers;
  final Comments? the4WayFlashersComments;
  final String? the4WayFlashersImage;
  final BucketLiner? dashLights;
  final String? dashLightsComments;
  final dynamic dashLightsImage;
  final BucketLiner? strobeLights;
  final String? strobeLightsComments;
  final dynamic strobeLightsImages;
  final BucketLiner? cabRoofLights;
  final String? cabRoofLightsComments;
  final dynamic cabRoofLightsImage;
  final BucketLiner? clearanceLights;
  final Comments? clearanceLightsComments;
  final String? clearanceLightsImage;
  final DateTime? dateAdded;

  Lights({
    this.idLights,
    this.headlights,
    this.headlightsComments,
    this.headlightsImage,
    this.brakeLights,
    this.brakeLightsComments,
    this.brakeLightsImage,
    this.reverseLights,
    this.reverseLightsComments,
    this.reverseLightsImage,
    this.warningLights,
    this.warningLightsComments,
    this.warningLightsImage,
    this.turnSignals,
    this.turnSignalsComments,
    this.turnSignalsImage,
    this.the4WayFlashers,
    this.the4WayFlashersComments,
    this.the4WayFlashersImage,
    this.dashLights,
    this.dashLightsComments,
    this.dashLightsImage,
    this.strobeLights,
    this.strobeLightsComments,
    this.strobeLightsImages,
    this.cabRoofLights,
    this.cabRoofLightsComments,
    this.cabRoofLightsImage,
    this.clearanceLights,
    this.clearanceLightsComments,
    this.clearanceLightsImage,
    this.dateAdded,
  });

  factory Lights.fromJson(String str) => Lights.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lights.fromMap(Map<String, dynamic> json) => Lights(
        idLights: json["id_lights"],
        headlights: bucketLinerValues.map[json["headlights"]]!,
        headlightsComments:
            ladderStrapsCommentsValues.map[json["headlights_comments"]]!,
        headlightsImage: json["headlights_image"],
        brakeLights: bucketLinerValues.map[json["brake_lights"]]!,
        brakeLightsComments: commentsValues.map[json["brake_lights_comments"]]!,
        brakeLightsImage: json["brake_lights_image"],
        reverseLights: bucketLinerValues.map[json["reverse_lights"]]!,
        reverseLightsComments: json["reverse_lights_comments"],
        reverseLightsImage: json["reverse_lights_image"],
        warningLights: bucketLinerValues.map[json["warning_lights"]]!,
        warningLightsComments:
            ladderStrapsCommentsValues.map[json["warning_lights_comments"]]!,
        warningLightsImage: json["warning_lights_image"],
        turnSignals: bucketLinerValues.map[json["turn_signals"]]!,
        turnSignalsComments:
            ladderStrapsCommentsValues.map[json["turn_signals_comments"]]!,
        turnSignalsImage: json["turn_signals_image"],
        the4WayFlashers: bucketLinerValues.map[json["4_way_flashers"]]!,
        the4WayFlashersComments:
            commentsValues.map[json["4_way_flashers_comments"]]!,
        the4WayFlashersImage: json["4_way_flashers_image"],
        dashLights: bucketLinerValues.map[json["dash_lights"]]!,
        dashLightsComments: json["dash_lights_comments"],
        dashLightsImage: json["dash_lights_image"],
        strobeLights: bucketLinerValues.map[json["strobe_lights"]]!,
        strobeLightsComments: json["strobe_lights_comments"],
        strobeLightsImages: json["strobe_lights_images"],
        cabRoofLights: bucketLinerValues.map[json["cab_roof_lights"]]!,
        cabRoofLightsComments: json["cab_roof_lights_comments"],
        cabRoofLightsImage: json["cab_roof_lights_image"],
        clearanceLights: bucketLinerValues.map[json["clearance_lights"]]!,
        clearanceLightsComments:
            commentsValues.map[json["clearance_lights_comments"]]!,
        clearanceLightsImage: json["clearance_lights_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_lights": idLights,
        "headlights": bucketLinerValues.reverse[headlights],
        "headlights_comments":
            ladderStrapsCommentsValues.reverse[headlightsComments],
        "headlights_image": headlightsImage,
        "brake_lights": bucketLinerValues.reverse[brakeLights],
        "brake_lights_comments": commentsValues.reverse[brakeLightsComments],
        "brake_lights_image": brakeLightsImage,
        "reverse_lights": bucketLinerValues.reverse[reverseLights],
        "reverse_lights_comments": reverseLightsComments,
        "reverse_lights_image": reverseLightsImage,
        "warning_lights": bucketLinerValues.reverse[warningLights],
        "warning_lights_comments":
            ladderStrapsCommentsValues.reverse[warningLightsComments],
        "warning_lights_image": warningLightsImage,
        "turn_signals": bucketLinerValues.reverse[turnSignals],
        "turn_signals_comments":
            ladderStrapsCommentsValues.reverse[turnSignalsComments],
        "turn_signals_image": turnSignalsImage,
        "4_way_flashers": bucketLinerValues.reverse[the4WayFlashers],
        "4_way_flashers_comments":
            commentsValues.reverse[the4WayFlashersComments],
        "4_way_flashers_image": the4WayFlashersImage,
        "dash_lights": bucketLinerValues.reverse[dashLights],
        "dash_lights_comments": dashLightsComments,
        "dash_lights_image": dashLightsImage,
        "strobe_lights": bucketLinerValues.reverse[strobeLights],
        "strobe_lights_comments": strobeLightsComments,
        "strobe_lights_images": strobeLightsImages,
        "cab_roof_lights": bucketLinerValues.reverse[cabRoofLights],
        "cab_roof_lights_comments": cabRoofLightsComments,
        "cab_roof_lights_image": cabRoofLightsImage,
        "clearance_lights": bucketLinerValues.reverse[clearanceLights],
        "clearance_lights_comments":
            commentsValues.reverse[clearanceLightsComments],
        "clearance_lights_image": clearanceLightsImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

class Measure {
  final int? idMeasure;
  final String? gas;
  final GasComments? gasComments;
  final String? gasImage;
  final int? mileage;
  final MileageComments? mileageComments;
  final String? mileageImage;
  final DateTime? dateAdded;

  Measure({
    this.idMeasure,
    this.gas,
    this.gasComments,
    this.gasImage,
    this.mileage,
    this.mileageComments,
    this.mileageImage,
    this.dateAdded,
  });

  factory Measure.fromJson(String str) => Measure.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Measure.fromMap(Map<String, dynamic> json) => Measure(
        idMeasure: json["id_measure"],
        gas: json["gas"],
        gasComments: gasCommentsValues.map[json["gas_comments"]]!,
        gasImage: json["gas_image"],
        mileage: json["mileage"],
        mileageComments: mileageCommentsValues.map[json["mileage_comments"]]!,
        mileageImage: json["mileage_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_measure": idMeasure,
        "gas": gas,
        "gas_comments": gasCommentsValues.reverse[gasComments],
        "gas_image": gasImage,
        "mileage": mileage,
        "mileage_comments": mileageCommentsValues.reverse[mileageComments],
        "mileage_image": mileageImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

enum GasComments { EMPTY, FULL, THE_34 }

final gasCommentsValues = EnumValues({
  "": GasComments.EMPTY,
  "Full": GasComments.FULL,
  "3/4": GasComments.THE_34
});

enum MileageComments { EMPTY, GOOD, MILEAGE_COMMENTS_GOOD }

final mileageCommentsValues = EnumValues({
  "": MileageComments.EMPTY,
  "Good": MileageComments.GOOD,
  "Good ": MileageComments.MILEAGE_COMMENTS_GOOD
});

class Security {
  final int? idSecurity;
  final BucketLiner? rtaMagnet;
  final LadderStrapsComments? rtaMagnetCommnets;
  final String? rtaMagnetImage;
  final BucketLiner? triangleReflectors;
  final Comments? triangleReflectorsComments;
  final String? triangleReflectorsImage;
  final BucketLiner? wheelChocks;
  final LadderStrapsComments? wheelChocksComments;
  final String? wheelChocksImage;
  final BucketLiner? fireExtinguisher;
  final Comments? fireExtinguisherComments;
  final String? fireExtinguisherImage;
  final BucketLiner? firstAidKitSafetyVest;
  final String? firstAidKitSafetyVestComments;
  final dynamic firstAidKitSafetyVestImage;
  final BucketLiner? backUpAlarm;
  final Comments? backUpAlarmComments;
  final String? backUpAlarmImage;
  final DateTime? dateAdded;

  Security({
    this.idSecurity,
    this.rtaMagnet,
    this.rtaMagnetCommnets,
    this.rtaMagnetImage,
    this.triangleReflectors,
    this.triangleReflectorsComments,
    this.triangleReflectorsImage,
    this.wheelChocks,
    this.wheelChocksComments,
    this.wheelChocksImage,
    this.fireExtinguisher,
    this.fireExtinguisherComments,
    this.fireExtinguisherImage,
    this.firstAidKitSafetyVest,
    this.firstAidKitSafetyVestComments,
    this.firstAidKitSafetyVestImage,
    this.backUpAlarm,
    this.backUpAlarmComments,
    this.backUpAlarmImage,
    this.dateAdded,
  });

  factory Security.fromJson(String str) => Security.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Security.fromMap(Map<String, dynamic> json) => Security(
        idSecurity: json["id_security"],
        rtaMagnet: bucketLinerValues.map[json["rta_magnet"]]!,
        rtaMagnetCommnets:
            ladderStrapsCommentsValues.map[json["rta_magnet_commnets"]]!,
        rtaMagnetImage: json["rta_magnet_image"],
        triangleReflectors: bucketLinerValues.map[json["triangle_reflectors"]]!,
        triangleReflectorsComments:
            commentsValues.map[json["triangle_reflectors_comments"]]!,
        triangleReflectorsImage: json["triangle_reflectors_image"],
        wheelChocks: bucketLinerValues.map[json["wheel_chocks"]]!,
        wheelChocksComments:
            ladderStrapsCommentsValues.map[json["wheel_chocks_comments"]]!,
        wheelChocksImage: json["wheel_chocks_image"],
        fireExtinguisher: bucketLinerValues.map[json["fire_extinguisher"]]!,
        fireExtinguisherComments:
            commentsValues.map[json["fire_extinguisher_comments"]]!,
        fireExtinguisherImage: json["fire_extinguisher_image"],
        firstAidKitSafetyVest:
            bucketLinerValues.map[json["first_aid_kit_safety_vest"]]!,
        firstAidKitSafetyVestComments:
            json["first_aid_kit_safety_vest_comments"],
        firstAidKitSafetyVestImage: json["first_aid_kit_safety_vest_image"],
        backUpAlarm: bucketLinerValues.map[json["back_up_alarm"]]!,
        backUpAlarmComments:
            commentsValues.map[json["back_up_alarm_comments"]]!,
        backUpAlarmImage: json["back_up_alarm_image"],
        dateAdded: json["date_added"] == null
            ? null
            : DateTime.parse(json["date_added"]),
      );

  Map<String, dynamic> toMap() => {
        "id_security": idSecurity,
        "rta_magnet": bucketLinerValues.reverse[rtaMagnet],
        "rta_magnet_commnets":
            ladderStrapsCommentsValues.reverse[rtaMagnetCommnets],
        "rta_magnet_image": rtaMagnetImage,
        "triangle_reflectors": bucketLinerValues.reverse[triangleReflectors],
        "triangle_reflectors_comments":
            commentsValues.reverse[triangleReflectorsComments],
        "triangle_reflectors_image": triangleReflectorsImage,
        "wheel_chocks": bucketLinerValues.reverse[wheelChocks],
        "wheel_chocks_comments":
            ladderStrapsCommentsValues.reverse[wheelChocksComments],
        "wheel_chocks_image": wheelChocksImage,
        "fire_extinguisher": bucketLinerValues.reverse[fireExtinguisher],
        "fire_extinguisher_comments":
            commentsValues.reverse[fireExtinguisherComments],
        "fire_extinguisher_image": fireExtinguisherImage,
        "first_aid_kit_safety_vest":
            bucketLinerValues.reverse[firstAidKitSafetyVest],
        "first_aid_kit_safety_vest_comments": firstAidKitSafetyVestComments,
        "first_aid_kit_safety_vest_image": firstAidKitSafetyVestImage,
        "back_up_alarm": bucketLinerValues.reverse[backUpAlarm],
        "back_up_alarm_comments": commentsValues.reverse[backUpAlarmComments],
        "back_up_alarm_image": backUpAlarmImage,
        "date_added": dateAdded?.toIso8601String(),
      };
}

class UserProfile {
  final String idUserFk;
  final Name name;
  final LastName lastName;
  final String homePhone;
  final String mobilePhone;
  final Address address;
  final DateTime birthdate;
  final dynamic middleName;
  final dynamic image;
  final int sequentialId;

  UserProfile({
    required this.idUserFk,
    required this.name,
    required this.lastName,
    required this.homePhone,
    required this.mobilePhone,
    required this.address,
    required this.birthdate,
    this.middleName,
    this.image,
    required this.sequentialId,
  });

  factory UserProfile.fromJson(String str) =>
      UserProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        idUserFk: json["id_user_fk"],
        name: nameValues.map[json["name"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        homePhone: json["home_phone"],
        mobilePhone: json["mobile_phone"],
        address: addressValues.map[json["address"]]!,
        birthdate: DateTime.parse(json["birthdate"]),
        middleName: json["middle_name"],
        image: json["image"],
        sequentialId: json["sequential_id"],
      );

  Map<String, dynamic> toMap() => {
        "id_user_fk": idUserFk,
        "name": nameValues.reverse[name],
        "last_name": lastNameValues.reverse[lastName],
        "home_phone": homePhone,
        "mobile_phone": mobilePhone,
        "address": addressValues.reverse[address],
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "middle_name": middleName,
        "image": image,
        "sequential_id": sequentialId,
      };
}

enum Address { THE_124_MAIN_ST, HOUSTON_TEXAS }

final addressValues = EnumValues({
  "Houston, Texas": Address.HOUSTON_TEXAS,
  "124 Main St.": Address.THE_124_MAIN_ST
});

enum LastName { CV, SMI_CV }

final lastNameValues =
    EnumValues({"CV": LastName.CV, "SMI CV": LastName.SMI_CV});

enum Name { EMPLOYEE, NAME_EMPLOYEE }

final nameValues =
    EnumValues({"Employee": Name.EMPLOYEE, "employee": Name.NAME_EMPLOYEE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
