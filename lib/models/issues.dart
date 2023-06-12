// To parse this JSON data, do
//
//     final issues = issuesFromMap(jsonString);

import 'dart:convert';

class Issues {
  final int idBucketInspectionFk;
  final BucketInspection bucketInspection;
  final int idCarBodyworkFk;
  final CarBodywork carBodywork;
  final int idEquipmentFk;
  final Equiment equiment;
  final String idUserFk;
  final UserProfile userProfile;
  final int idExtraFk;
  final Extra extra;
  final int idFluidsCheckFk;
  final FluidCheck fluidCheck;
  final int idLightsFk;
  final Lights lights;
  final int idMeasureFk;
  final Measure measure;
  final int idSecurityFk;
  final Security security;
  final int issues;

  Issues({
    required this.idBucketInspectionFk,
    required this.bucketInspection,
    required this.idCarBodyworkFk,
    required this.carBodywork,
    required this.idEquipmentFk,
    required this.equiment,
    required this.idUserFk,
    required this.userProfile,
    required this.idExtraFk,
    required this.extra,
    required this.idFluidsCheckFk,
    required this.fluidCheck,
    required this.idLightsFk,
    required this.lights,
    required this.idMeasureFk,
    required this.measure,
    required this.idSecurityFk,
    required this.security,
    required this.issues,
  });

  factory Issues.fromJson(String str) => Issues.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Issues.fromMap(Map<String, dynamic> json) => Issues(
        idBucketInspectionFk: json["id_bucket_inspection_fk"],
        bucketInspection: BucketInspection.fromMap(json["bucket_inspection"]),
        idCarBodyworkFk: json["id_car_bodywork_fk"],
        carBodywork: CarBodywork.fromMap(json["car_bodywork"]),
        idEquipmentFk: json["id_equipment_fk"],
        equiment: Equiment.fromMap(json["equiment"]),
        idUserFk: json["id_user_fk"],
        userProfile: UserProfile.fromMap(json["user_profile"]),
        idExtraFk: json["id_extra_fk"],
        extra: Extra.fromMap(json["extra"]),
        idFluidsCheckFk: json["id_fluids_check_fk"],
        fluidCheck: FluidCheck.fromMap(json["fluid_check"]),
        idLightsFk: json["id_lights_fk"],
        lights: Lights.fromMap(json["lights"]),
        idMeasureFk: json["id_measure_fk"],
        measure: Measure.fromMap(json["measure"]),
        idSecurityFk: json["id_security_fk"],
        security: Security.fromMap(json["security"]),
        issues: json["issues"],
      );

  Map<String, dynamic> toMap() => {
        "id_bucket_inspection_fk": idBucketInspectionFk,
        "bucket_inspection": bucketInspection.toMap(),
        "id_car_bodywork_fk": idCarBodyworkFk,
        "car_bodywork": carBodywork.toMap(),
        "id_equipment_fk": idEquipmentFk,
        "equiment": equiment.toMap(),
        "id_user_fk": idUserFk,
        "user_profile": userProfile.toMap(),
        "id_extra_fk": idExtraFk,
        "extra": extra.toMap(),
        "id_fluids_check_fk": idFluidsCheckFk,
        "fluid_check": fluidCheck.toMap(),
        "id_lights_fk": idLightsFk,
        "lights": lights.toMap(),
        "id_measure_fk": idMeasureFk,
        "measure": measure.toMap(),
        "id_security_fk": idSecurityFk,
        "security": security.toMap(),
        "issues": issues,
      };
}

class BucketInspection {
  final int idBucketInspection;
  final String insulated;
  final String? insulatedComments;
  final dynamic insulatedImage;
  final String holesDrilled;
  final String? holesDrilledComments;
  final String? holesDrilledImage;
  final String bucketLiner;
  final String? bucketLinerComments;
  final dynamic bucketLinerImage;

  BucketInspection({
    required this.idBucketInspection,
    required this.insulated,
    this.insulatedComments,
    this.insulatedImage,
    required this.holesDrilled,
    this.holesDrilledComments,
    this.holesDrilledImage,
    required this.bucketLiner,
    this.bucketLinerComments,
    this.bucketLinerImage,
  });

  factory BucketInspection.fromJson(String str) =>
      BucketInspection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BucketInspection.fromMap(Map<String, dynamic> json) =>
      BucketInspection(
        idBucketInspection: json["id_bucket_inspection"],
        insulated: json["insulated"],
        insulatedComments: json["insulated_comments"],
        insulatedImage: json["insulated_image"],
        holesDrilled: json["holes_drilled"],
        holesDrilledComments: json["holes_drilled_comments"],
        holesDrilledImage: json["holes_drilled_image"],
        bucketLiner: json["bucket_liner"],
        bucketLinerComments: json["bucket_liner_comments"],
        bucketLinerImage: json["bucket_liner_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_bucket_inspection": idBucketInspection,
        "insulated": insulated,
        "insulated_comments": insulatedComments,
        "insulated_image": insulatedImage,
        "holes_drilled": holesDrilled,
        "holes_drilled_comments": holesDrilledComments,
        "holes_drilled_image": holesDrilledImage,
        "bucket_liner": bucketLiner,
        "bucket_liner_comments": bucketLinerComments,
        "bucket_liner_image": bucketLinerImage,
      };
}

class CarBodywork {
  final int idCarBodywork;
  final String wiperBladesFront;
  final String? wiperBladesFrontComments;
  final String? wiperBladesFrontImage;
  final String wiperBladesBack;
  final String? wiperBladesBackComments;
  final dynamic wiperBladesBackImage;
  final String windshieldWiperFront;
  final String windshieldWiperBack;
  final String generalBody;
  final String? generalBodyComments;
  final dynamic generalBodyImage;
  final String decaling;
  final String? decalingComments;
  final dynamic decalingImage;
  final String tires;
  final String? tiresComments;
  final dynamic tiresImage;
  final String glass;
  final String? glassComments;
  final dynamic glassImage;
  final String mirrors;
  final String? mirrorsComments;
  final String? mirrorsImage;
  final String parking;
  final String? parkingComments;
  final dynamic parkingImage;
  final String brakes;
  final String? brakesComments;
  final dynamic brakesImage;
  final String emgBrakes;
  final String? emgBrakesComments;
  final dynamic emgBrakesImage;
  final String horn;
  final String? hornComments;
  final dynamic hornImage;

  CarBodywork({
    required this.idCarBodywork,
    required this.wiperBladesFront,
    this.wiperBladesFrontComments,
    this.wiperBladesFrontImage,
    required this.wiperBladesBack,
    this.wiperBladesBackComments,
    this.wiperBladesBackImage,
    required this.windshieldWiperFront,
    required this.windshieldWiperBack,
    required this.generalBody,
    this.generalBodyComments,
    this.generalBodyImage,
    required this.decaling,
    this.decalingComments,
    this.decalingImage,
    required this.tires,
    this.tiresComments,
    this.tiresImage,
    required this.glass,
    this.glassComments,
    this.glassImage,
    required this.mirrors,
    this.mirrorsComments,
    this.mirrorsImage,
    required this.parking,
    this.parkingComments,
    this.parkingImage,
    required this.brakes,
    this.brakesComments,
    this.brakesImage,
    required this.emgBrakes,
    this.emgBrakesComments,
    this.emgBrakesImage,
    required this.horn,
    this.hornComments,
    this.hornImage,
  });

  factory CarBodywork.fromJson(String str) =>
      CarBodywork.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarBodywork.fromMap(Map<String, dynamic> json) => CarBodywork(
        idCarBodywork: json["id_car_bodywork"],
        wiperBladesFront: json["wiper_blades_front"],
        wiperBladesFrontComments: json["wiper_blades_front_comments"],
        wiperBladesFrontImage: json["wiper_blades_front_image"],
        wiperBladesBack: json["wiper_blades_back"],
        wiperBladesBackComments: json["wiper_blades_back_comments"],
        wiperBladesBackImage: json["wiper_blades_back_image"],
        windshieldWiperFront: json["windshield_wiper_front"],
        windshieldWiperBack: json["windshield_wiper_back"],
        generalBody: json["general_body"],
        generalBodyComments: json["general_body_comments"],
        generalBodyImage: json["general_body_image"],
        decaling: json["decaling"],
        decalingComments: json["decaling_comments"],
        decalingImage: json["decaling_image"],
        tires: json["tires"],
        tiresComments: json["tires_comments"],
        tiresImage: json["tires_image"],
        glass: json["glass"],
        glassComments: json["glass_comments"],
        glassImage: json["glass_image"],
        mirrors: json["mirrors"],
        mirrorsComments: json["mirrors_comments"],
        mirrorsImage: json["mirrors_image"],
        parking: json["parking"],
        parkingComments: json["parking_comments"],
        parkingImage: json["parking_image"],
        brakes: json["brakes"],
        brakesComments: json["brakes_comments"],
        brakesImage: json["brakes_image"],
        emgBrakes: json["emg_brakes"],
        emgBrakesComments: json["emg_brakes_comments"],
        emgBrakesImage: json["emg_brakes_image"],
        horn: json["horn"],
        hornComments: json["horn_comments"],
        hornImage: json["horn_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_car_bodywork": idCarBodywork,
        "wiper_blades_front": wiperBladesFront,
        "wiper_blades_front_comments": wiperBladesFrontComments,
        "wiper_blades_front_image": wiperBladesFrontImage,
        "wiper_blades_back": wiperBladesBack,
        "wiper_blades_back_comments": wiperBladesBackComments,
        "wiper_blades_back_image": wiperBladesBackImage,
        "windshield_wiper_front": windshieldWiperFront,
        "windshield_wiper_back": windshieldWiperBack,
        "general_body": generalBody,
        "general_body_comments": generalBodyComments,
        "general_body_image": generalBodyImage,
        "decaling": decaling,
        "decaling_comments": decalingComments,
        "decaling_image": decalingImage,
        "tires": tires,
        "tires_comments": tiresComments,
        "tires_image": tiresImage,
        "glass": glass,
        "glass_comments": glassComments,
        "glass_image": glassImage,
        "mirrors": mirrors,
        "mirrors_comments": mirrorsComments,
        "mirrors_image": mirrorsImage,
        "parking": parking,
        "parking_comments": parkingComments,
        "parking_image": parkingImage,
        "brakes": brakes,
        "brakes_comments": brakesComments,
        "brakes_image": brakesImage,
        "emg_brakes": emgBrakes,
        "emg_brakes_comments": emgBrakesComments,
        "emg_brakes_image": emgBrakesImage,
        "horn": horn,
        "horn_comments": hornComments,
        "horn_image": hornImage,
      };
}

class Equiment {
  final int idEquipment;
  final String ignitionKey;
  final String? ignitionKeyComments;
  final String? ignitionKeyImage;
  final String binsBoxKey;
  final String? binsBoxKeyComments;
  final dynamic binsBoxKeyImage;
  final String vehicleRegistrationCopy;
  final String? vehicleRegistrationCopyComments;
  final dynamic vehicleRegistrationCopyImage;
  final String vehicleInsuranceCopy;
  final String? vehicleInsuranceCopyComments;
  final dynamic vehicleInsuranceCopyImage;
  final String bucketLiftOperatorManual;
  final String? bucketLiftOperatorManualComments;
  final dynamic bucketLiftOperatorManualImage;

  Equiment({
    required this.idEquipment,
    required this.ignitionKey,
    this.ignitionKeyComments,
    this.ignitionKeyImage,
    required this.binsBoxKey,
    this.binsBoxKeyComments,
    this.binsBoxKeyImage,
    required this.vehicleRegistrationCopy,
    this.vehicleRegistrationCopyComments,
    this.vehicleRegistrationCopyImage,
    required this.vehicleInsuranceCopy,
    this.vehicleInsuranceCopyComments,
    this.vehicleInsuranceCopyImage,
    required this.bucketLiftOperatorManual,
    this.bucketLiftOperatorManualComments,
    this.bucketLiftOperatorManualImage,
  });

  factory Equiment.fromJson(String str) => Equiment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Equiment.fromMap(Map<String, dynamic> json) => Equiment(
        idEquipment: json["id_equipment"],
        ignitionKey: json["ignition_key"],
        ignitionKeyComments: json["ignition_key_comments"],
        ignitionKeyImage: json["ignition_key_image"],
        binsBoxKey: json["bins_box_key"],
        binsBoxKeyComments: json["bins_box_key_comments"],
        binsBoxKeyImage: json["bins_box_key_image"],
        vehicleRegistrationCopy: json["vehicle_registration_copy"],
        vehicleRegistrationCopyComments:
            json["vehicle_registration_copy_comments"],
        vehicleRegistrationCopyImage: json["vehicle_registration_copy_image"],
        vehicleInsuranceCopy: json["vehicle_insurance_copy"],
        vehicleInsuranceCopyComments: json["vehicle_insurance_copy_comments"],
        vehicleInsuranceCopyImage: json["vehicle_insurance_copy_image"],
        bucketLiftOperatorManual: json["bucket_lift_operator_manual"],
        bucketLiftOperatorManualComments:
            json["bucket_lift_operator_manual_comments"],
        bucketLiftOperatorManualImage:
            json["bucket_lift_operator_manual_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_equipment": idEquipment,
        "ignition_key": ignitionKey,
        "ignition_key_comments": ignitionKeyComments,
        "ignition_key_image": ignitionKeyImage,
        "bins_box_key": binsBoxKey,
        "bins_box_key_comments": binsBoxKeyComments,
        "bins_box_key_image": binsBoxKeyImage,
        "vehicle_registration_copy": vehicleRegistrationCopy,
        "vehicle_registration_copy_comments": vehicleRegistrationCopyComments,
        "vehicle_registration_copy_image": vehicleRegistrationCopyImage,
        "vehicle_insurance_copy": vehicleInsuranceCopy,
        "vehicle_insurance_copy_comments": vehicleInsuranceCopyComments,
        "vehicle_insurance_copy_image": vehicleInsuranceCopyImage,
        "bucket_lift_operator_manual": bucketLiftOperatorManual,
        "bucket_lift_operator_manual_comments":
            bucketLiftOperatorManualComments,
        "bucket_lift_operator_manual_image": bucketLiftOperatorManualImage,
      };
}

class Extra {
  final int idExtra;
  final String ladder;
  final String? ladderComments;
  final dynamic ladderImage;
  final String stepLadder;
  final String? stepLadderComments;
  final dynamic stepLadderImage;
  final String ladderStraps;
  final String? ladderStrapsComments;
  final dynamic ladderStrapsImage;
  final String hydraulicFluidForBucket;
  final String? hydraulicFluidForBucketComments;
  final dynamic hydraulicFluidForBucketImage;
  final String fiberReelRack;
  final String? fiberReelRackComments;
  final String? fiberReelRackImage;
  final String binsLockedAndSecure;
  final String? binsLockedAndSecureComments;
  final dynamic binsLockedAndSecureImage;
  final String safetyHarness;
  final String? safetyHarnessComments;
  final dynamic safetyHarnessImage;
  final String lanyardSafetyHarness;
  final String? lanyardSafetyHarnessComments;
  final dynamic lanyardSafetyHarnessImage;

  Extra({
    required this.idExtra,
    required this.ladder,
    this.ladderComments,
    this.ladderImage,
    required this.stepLadder,
    this.stepLadderComments,
    this.stepLadderImage,
    required this.ladderStraps,
    this.ladderStrapsComments,
    this.ladderStrapsImage,
    required this.hydraulicFluidForBucket,
    this.hydraulicFluidForBucketComments,
    this.hydraulicFluidForBucketImage,
    required this.fiberReelRack,
    this.fiberReelRackComments,
    this.fiberReelRackImage,
    required this.binsLockedAndSecure,
    this.binsLockedAndSecureComments,
    this.binsLockedAndSecureImage,
    required this.safetyHarness,
    this.safetyHarnessComments,
    this.safetyHarnessImage,
    required this.lanyardSafetyHarness,
    this.lanyardSafetyHarnessComments,
    this.lanyardSafetyHarnessImage,
  });

  factory Extra.fromJson(String str) => Extra.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Extra.fromMap(Map<String, dynamic> json) => Extra(
        idExtra: json["id_extra"],
        ladder: json["ladder"],
        ladderComments: json["ladder_comments"],
        ladderImage: json["ladder_image"],
        stepLadder: json["step_ladder"],
        stepLadderComments: json["step_ladder_comments"],
        stepLadderImage: json["step_ladder_image"],
        ladderStraps: json["ladder_straps"],
        ladderStrapsComments: json["ladder_straps_comments"],
        ladderStrapsImage: json["ladder_straps_image"],
        hydraulicFluidForBucket: json["hydraulic_fluid_for_bucket"],
        hydraulicFluidForBucketComments:
            json["hydraulic_fluid_for_bucket_comments"],
        hydraulicFluidForBucketImage: json["hydraulic_fluid_for_bucket_image"],
        fiberReelRack: json["fiber_reel_rack"],
        fiberReelRackComments: json["fiber_reel_rack_comments"],
        fiberReelRackImage: json["fiber_reel_rack_image"],
        binsLockedAndSecure: json["bins_locked_and_secure"],
        binsLockedAndSecureComments: json["bins_locked_and_secure_comments"],
        binsLockedAndSecureImage: json["bins_locked_and_secure_image"],
        safetyHarness: json["safety_harness"],
        safetyHarnessComments: json["safety_harness_comments"],
        safetyHarnessImage: json["safety_harness_image"],
        lanyardSafetyHarness: json["lanyard_safety_harness"],
        lanyardSafetyHarnessComments: json["lanyard_safety_harness_comments"],
        lanyardSafetyHarnessImage: json["lanyard_safety_harness_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_extra": idExtra,
        "ladder": ladder,
        "ladder_comments": ladderComments,
        "ladder_image": ladderImage,
        "step_ladder": stepLadder,
        "step_ladder_comments": stepLadderComments,
        "step_ladder_image": stepLadderImage,
        "ladder_straps": ladderStraps,
        "ladder_straps_comments": ladderStrapsComments,
        "ladder_straps_image": ladderStrapsImage,
        "hydraulic_fluid_for_bucket": hydraulicFluidForBucket,
        "hydraulic_fluid_for_bucket_comments": hydraulicFluidForBucketComments,
        "hydraulic_fluid_for_bucket_image": hydraulicFluidForBucketImage,
        "fiber_reel_rack": fiberReelRack,
        "fiber_reel_rack_comments": fiberReelRackComments,
        "fiber_reel_rack_image": fiberReelRackImage,
        "bins_locked_and_secure": binsLockedAndSecure,
        "bins_locked_and_secure_comments": binsLockedAndSecureComments,
        "bins_locked_and_secure_image": binsLockedAndSecureImage,
        "safety_harness": safetyHarness,
        "safety_harness_comments": safetyHarnessComments,
        "safety_harness_image": safetyHarnessImage,
        "lanyard_safety_harness": lanyardSafetyHarness,
        "lanyard_safety_harness_comments": lanyardSafetyHarnessComments,
        "lanyard_safety_harness_image": lanyardSafetyHarnessImage,
      };
}

class FluidCheck {
  final int idFluidsCheck;
  final String engineOil;
  final String? engineOilComments;
  final dynamic engineOilImage;
  final String transmission;
  final String? transmissionComments;
  final dynamic transmissionImage;
  final String coolant;
  final String? coolantComments;
  final dynamic coolantImage;
  final String powerSteering;
  final String? powerSteeringComments;
  final dynamic powerSteeringImage;
  final String dieselExhaustFluid;
  final String? dieselExhaustFluidComments;
  final dynamic dieselExhaustFluidImage;
  final String windshieldWasherFluid;
  final String? windshieldWasherFluidComments;
  final String? windshieldWasherFluidImage;

  FluidCheck({
    required this.idFluidsCheck,
    required this.engineOil,
    this.engineOilComments,
    this.engineOilImage,
    required this.transmission,
    this.transmissionComments,
    this.transmissionImage,
    required this.coolant,
    this.coolantComments,
    this.coolantImage,
    required this.powerSteering,
    this.powerSteeringComments,
    this.powerSteeringImage,
    required this.dieselExhaustFluid,
    this.dieselExhaustFluidComments,
    this.dieselExhaustFluidImage,
    required this.windshieldWasherFluid,
    this.windshieldWasherFluidComments,
    this.windshieldWasherFluidImage,
  });

  factory FluidCheck.fromJson(String str) =>
      FluidCheck.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluidCheck.fromMap(Map<String, dynamic> json) => FluidCheck(
        idFluidsCheck: json["id_fluids_check"],
        engineOil: json["engine_oil"],
        engineOilComments: json["engine_oil_comments"],
        engineOilImage: json["engine_oil_image"],
        transmission: json["transmission"],
        transmissionComments: json["transmission_comments"],
        transmissionImage: json["transmission_image"],
        coolant: json["coolant"],
        coolantComments: json["coolant_comments"],
        coolantImage: json["coolant_image"],
        powerSteering: json["power_steering"],
        powerSteeringComments: json["power_steering_comments"],
        powerSteeringImage: json["power_steering_image"],
        dieselExhaustFluid: json["diesel_exhaust_fluid"],
        dieselExhaustFluidComments: json["diesel_exhaust_fluid_comments"],
        dieselExhaustFluidImage: json["diesel_exhaust_fluid_image"],
        windshieldWasherFluid: json["windshield_washer_fluid"],
        windshieldWasherFluidComments: json["windshield_washer_fluid_comments"],
        windshieldWasherFluidImage: json["windshield_washer_fluid_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_fluids_check": idFluidsCheck,
        "engine_oil": engineOil,
        "engine_oil_comments": engineOilComments,
        "engine_oil_image": engineOilImage,
        "transmission": transmission,
        "transmission_comments": transmissionComments,
        "transmission_image": transmissionImage,
        "coolant": coolant,
        "coolant_comments": coolantComments,
        "coolant_image": coolantImage,
        "power_steering": powerSteering,
        "power_steering_comments": powerSteeringComments,
        "power_steering_image": powerSteeringImage,
        "diesel_exhaust_fluid": dieselExhaustFluid,
        "diesel_exhaust_fluid_comments": dieselExhaustFluidComments,
        "diesel_exhaust_fluid_image": dieselExhaustFluidImage,
        "windshield_washer_fluid": windshieldWasherFluid,
        "windshield_washer_fluid_comments": windshieldWasherFluidComments,
        "windshield_washer_fluid_image": windshieldWasherFluidImage,
      };
}

class Lights {
  final int idLights;
  final String headlights;
  final String? headlightsComments;
  final String? headlightsImage;
  final String brakeLights;
  final String? brakeLightsComments;
  final dynamic brakeLightsImage;
  final String reverseLights;
  final String? reverseLightsComments;
  final dynamic reverseLightsImage;
  final String warningLights;
  final String? warningLightsComments;
  final String? warningLightsImage;
  final String turnSignals;
  final String? turnSignalsComments;
  final dynamic turnSignalsImage;
  final String the4WayFlashers;
  final String? the4WayFlashersComments;
  final dynamic the4WayFlashersImage;
  final String dashLights;
  final String? dashLightsComments;
  final dynamic dashLightsImage;
  final String strobeLights;
  final String? strobeLightsComments;
  final dynamic strobeLightsImages;
  final String cabRoofLights;
  final String? cabRoofLightsComments;
  final dynamic cabRoofLightsImage;
  final String clearanceLights;
  final String? clearanceLightsComments;
  final dynamic clearanceLightsImage;

  Lights({
    required this.idLights,
    required this.headlights,
    this.headlightsComments,
    this.headlightsImage,
    required this.brakeLights,
    this.brakeLightsComments,
    this.brakeLightsImage,
    required this.reverseLights,
    this.reverseLightsComments,
    this.reverseLightsImage,
    required this.warningLights,
    this.warningLightsComments,
    this.warningLightsImage,
    required this.turnSignals,
    this.turnSignalsComments,
    this.turnSignalsImage,
    required this.the4WayFlashers,
    this.the4WayFlashersComments,
    this.the4WayFlashersImage,
    required this.dashLights,
    this.dashLightsComments,
    this.dashLightsImage,
    required this.strobeLights,
    this.strobeLightsComments,
    this.strobeLightsImages,
    required this.cabRoofLights,
    this.cabRoofLightsComments,
    this.cabRoofLightsImage,
    required this.clearanceLights,
    this.clearanceLightsComments,
    this.clearanceLightsImage,
  });

  factory Lights.fromJson(String str) => Lights.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lights.fromMap(Map<String, dynamic> json) => Lights(
        idLights: json["id_lights"],
        headlights: json["headlights"],
        headlightsComments: json["headlights_comments"],
        headlightsImage: json["headlights_image"],
        brakeLights: json["brake_lights"],
        brakeLightsComments: json["brake_lights_comments"],
        brakeLightsImage: json["brake_lights_image"],
        reverseLights: json["reverse_lights"],
        reverseLightsComments: json["reverse_lights_comments"],
        reverseLightsImage: json["reverse_lights_image"],
        warningLights: json["warning_lights"],
        warningLightsComments: json["warning_lights_comments"],
        warningLightsImage: json["warning_lights_image"],
        turnSignals: json["turn_signals"],
        turnSignalsComments: json["turn_signals_comments"],
        turnSignalsImage: json["turn_signals_image"],
        the4WayFlashers: json["4_way_flashers"],
        the4WayFlashersComments: json["4_way_flashers_comments"],
        the4WayFlashersImage: json["4_way_flashers_image"],
        dashLights: json["dash_lights"],
        dashLightsComments: json["dash_lights_comments"],
        dashLightsImage: json["dash_lights_image"],
        strobeLights: json["strobe_lights"],
        strobeLightsComments: json["strobe_lights_comments"],
        strobeLightsImages: json["strobe_lights_images"],
        cabRoofLights: json["cab_roof_lights"],
        cabRoofLightsComments: json["cab_roof_lights_comments"],
        cabRoofLightsImage: json["cab_roof_lights_image"],
        clearanceLights: json["clearance_lights"],
        clearanceLightsComments: json["clearance_lights_comments"],
        clearanceLightsImage: json["clearance_lights_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_lights": idLights,
        "headlights": headlights,
        "headlights_comments": headlightsComments,
        "headlights_image": headlightsImage,
        "brake_lights": brakeLights,
        "brake_lights_comments": brakeLightsComments,
        "brake_lights_image": brakeLightsImage,
        "reverse_lights": reverseLights,
        "reverse_lights_comments": reverseLightsComments,
        "reverse_lights_image": reverseLightsImage,
        "warning_lights": warningLights,
        "warning_lights_comments": warningLightsComments,
        "warning_lights_image": warningLightsImage,
        "turn_signals": turnSignals,
        "turn_signals_comments": turnSignalsComments,
        "turn_signals_image": turnSignalsImage,
        "4_way_flashers": the4WayFlashers,
        "4_way_flashers_comments": the4WayFlashersComments,
        "4_way_flashers_image": the4WayFlashersImage,
        "dash_lights": dashLights,
        "dash_lights_comments": dashLightsComments,
        "dash_lights_image": dashLightsImage,
        "strobe_lights": strobeLights,
        "strobe_lights_comments": strobeLightsComments,
        "strobe_lights_images": strobeLightsImages,
        "cab_roof_lights": cabRoofLights,
        "cab_roof_lights_comments": cabRoofLightsComments,
        "cab_roof_lights_image": cabRoofLightsImage,
        "clearance_lights": clearanceLights,
        "clearance_lights_comments": clearanceLightsComments,
        "clearance_lights_image": clearanceLightsImage,
      };
}

class Measure {
  final int idMeasure;
  final String gas;
  final String? gasComments;
  final String? gasImage;
  final int mileage;
  final String? mileageComments;
  final String? mileageImage;

  Measure({
    required this.idMeasure,
    required this.gas,
    this.gasComments,
    this.gasImage,
    required this.mileage,
    this.mileageComments,
    this.mileageImage,
  });

  factory Measure.fromJson(String str) => Measure.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Measure.fromMap(Map<String, dynamic> json) => Measure(
        idMeasure: json["id_measure"],
        gas: json["gas"],
        gasComments: json["gas_comments"],
        gasImage: json["gas_image"],
        mileage: json["mileage"],
        mileageComments: json["mileage_comments"],
        mileageImage: json["mileage_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_measure": idMeasure,
        "gas": gas,
        "gas_comments": gasComments,
        "gas_image": gasImage,
        "mileage": mileage,
        "mileage_comments": mileageComments,
        "mileage_image": mileageImage,
      };
}

class Security {
  final int idSecurity;
  final String rtaMagnet;
  final String? rtaMagnetCommnets;
  final dynamic rtaMagnetImage;
  final String triangleReflectors;
  final String? triangleReflectorsComments;
  final dynamic triangleReflectorsImage;
  final String wheelChocks;
  final String? wheelChocksComments;
  final dynamic wheelChocksImage;
  final String fireExtinguisher;
  final String? fireExtinguisherComments;
  final dynamic fireExtinguisherImage;
  final String firstAidKitSafetyVest;
  final String? firstAidKitSafetyVestComments;
  final dynamic firstAidKitSafetyVestImage;
  final String backUpAlarm;
  final String? backUpAlarmComments;
  final dynamic backUpAlarmImage;

  Security({
    required this.idSecurity,
    required this.rtaMagnet,
    this.rtaMagnetCommnets,
    this.rtaMagnetImage,
    required this.triangleReflectors,
    this.triangleReflectorsComments,
    this.triangleReflectorsImage,
    required this.wheelChocks,
    this.wheelChocksComments,
    this.wheelChocksImage,
    required this.fireExtinguisher,
    this.fireExtinguisherComments,
    this.fireExtinguisherImage,
    required this.firstAidKitSafetyVest,
    this.firstAidKitSafetyVestComments,
    this.firstAidKitSafetyVestImage,
    required this.backUpAlarm,
    this.backUpAlarmComments,
    this.backUpAlarmImage,
  });

  factory Security.fromJson(String str) => Security.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Security.fromMap(Map<String, dynamic> json) => Security(
        idSecurity: json["id_security"],
        rtaMagnet: json["rta_magnet"],
        rtaMagnetCommnets: json["rta_magnet_commnets"],
        rtaMagnetImage: json["rta_magnet_image"],
        triangleReflectors: json["triangle_reflectors"],
        triangleReflectorsComments: json["triangle_reflectors_comments"],
        triangleReflectorsImage: json["triangle_reflectors_image"],
        wheelChocks: json["wheel_chocks"],
        wheelChocksComments: json["wheel_chocks_comments"],
        wheelChocksImage: json["wheel_chocks_image"],
        fireExtinguisher: json["fire_extinguisher"],
        fireExtinguisherComments: json["fire_extinguisher_comments"],
        fireExtinguisherImage: json["fire_extinguisher_image"],
        firstAidKitSafetyVest: json["first_aid_kit_safety_vest"],
        firstAidKitSafetyVestComments:
            json["first_aid_kit_safety_vest_comments"],
        firstAidKitSafetyVestImage: json["first_aid_kit_safety_vest_image"],
        backUpAlarm: json["back_up_alarm"],
        backUpAlarmComments: json["back_up_alarm_comments"],
        backUpAlarmImage: json["back_up_alarm_image"],
      );

  Map<String, dynamic> toMap() => {
        "id_security": idSecurity,
        "rta_magnet": rtaMagnet,
        "rta_magnet_commnets": rtaMagnetCommnets,
        "rta_magnet_image": rtaMagnetImage,
        "triangle_reflectors": triangleReflectors,
        "triangle_reflectors_comments": triangleReflectorsComments,
        "triangle_reflectors_image": triangleReflectorsImage,
        "wheel_chocks": wheelChocks,
        "wheel_chocks_comments": wheelChocksComments,
        "wheel_chocks_image": wheelChocksImage,
        "fire_extinguisher": fireExtinguisher,
        "fire_extinguisher_comments": fireExtinguisherComments,
        "fire_extinguisher_image": fireExtinguisherImage,
        "first_aid_kit_safety_vest": firstAidKitSafetyVest,
        "first_aid_kit_safety_vest_comments": firstAidKitSafetyVestComments,
        "first_aid_kit_safety_vest_image": firstAidKitSafetyVestImage,
        "back_up_alarm": backUpAlarm,
        "back_up_alarm_comments": backUpAlarmComments,
        "back_up_alarm_image": backUpAlarmImage,
      };
}

class UserProfile {
  final String idUserFk;
  final String name;
  final String lastName;
  final String homePhone;
  final String mobilePhone;
  final String address;
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
        name: json["name"],
        lastName: json["last_name"],
        homePhone: json["home_phone"],
        mobilePhone: json["mobile_phone"],
        address: json["address"],
        birthdate: DateTime.parse(json["birthdate"]),
        middleName: json["middle_name"],
        image: json["image"],
        sequentialId: json["sequential_id"],
      );

  Map<String, dynamic> toMap() => {
        "id_user_fk": idUserFk,
        "name": name,
        "last_name": lastName,
        "home_phone": homePhone,
        "mobile_phone": mobilePhone,
        "address": address,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "middle_name": middleName,
        "image": image,
        "sequential_id": sequentialId,
      };
}
