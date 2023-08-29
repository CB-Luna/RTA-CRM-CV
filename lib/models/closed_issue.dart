// To parse this JSON data, do
//
//     final issueClosed = issueClosedFromMap(jsonString);

import 'dart:convert';

class IssueClosed {
  final int idVehicle;
  final int idFluidsCheckRFk;
  final FluidCheck fluidCheckR;
  final int? idFluidsCheckDFk;
  final FluidCheck fluidCheckD;
  final int idLightsRFk;
  final Lights lightsR;
  final int? idLightsDFk;
  final Lights lightsD;
  final int idCarBodyworkRFk;
  final Map<String, int?> carBodyworkR;
  final int? idCarBodyworkDFk;
  final Map<String, int?> carBodyworkD;
  final int idSecurityRFk;
  final Security securityR;
  final int? idSecurityDFk;
  final Security securityD;
  final int idExtraRFk;
  final Extra extraR;
  final int? idExtraDFk;
  final Extra extraD;
  final int idEquipmentRFk;
  final Equiment equimentR;
  final int? idEquipmentDFk;
  final Equiment equimentD;
  final int idBucketInspectionRFk;
  final BucketInspection bucketInspectionR;
  final int? idBucketInspectionDFk;
  final BucketInspection bucketInspectionD;

  IssueClosed({
    required this.idVehicle,
    required this.idFluidsCheckRFk,
    required this.fluidCheckR,
    this.idFluidsCheckDFk,
    required this.fluidCheckD,
    required this.idLightsRFk,
    required this.lightsR,
    this.idLightsDFk,
    required this.lightsD,
    required this.idCarBodyworkRFk,
    required this.carBodyworkR,
    this.idCarBodyworkDFk,
    required this.carBodyworkD,
    required this.idSecurityRFk,
    required this.securityR,
    this.idSecurityDFk,
    required this.securityD,
    required this.idExtraRFk,
    required this.extraR,
    this.idExtraDFk,
    required this.extraD,
    required this.idEquipmentRFk,
    required this.equimentR,
    this.idEquipmentDFk,
    required this.equimentD,
    required this.idBucketInspectionRFk,
    required this.bucketInspectionR,
    this.idBucketInspectionDFk,
    required this.bucketInspectionD,
  });

  factory IssueClosed.fromJson(String str) =>
      IssueClosed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IssueClosed.fromMap(Map<String, dynamic> json) => IssueClosed(
        idVehicle: json["id_vehicle"],
        idFluidsCheckRFk: json["id_fluids_check_r_fk"],
        fluidCheckR: FluidCheck.fromMap(json["fluid_check_r"]),
        idFluidsCheckDFk: json["id_fluids_check_d_fk"],
        fluidCheckD: FluidCheck.fromMap(json["fluid_check_d"]),
        idLightsRFk: json["id_lights_r_fk"],
        lightsR: Lights.fromMap(json["lights_r"]),
        idLightsDFk: json["id_lights_d_fk"],
        lightsD: Lights.fromMap(json["lights_d"]),
        idCarBodyworkRFk: json["id_car_bodywork_r_fk"],
        carBodyworkR: Map.from(json["car_bodywork_r"])
            .map((k, v) => MapEntry<String, int?>(k, v)),
        idCarBodyworkDFk: json["id_car_bodywork_d_fk"],
        carBodyworkD: Map.from(json["car_bodywork_d"])
            .map((k, v) => MapEntry<String, int?>(k, v)),
        idSecurityRFk: json["id_security_r_fk"],
        securityR: Security.fromMap(json["security_r"]),
        idSecurityDFk: json["id_security_d_fk"],
        securityD: Security.fromMap(json["security_d"]),
        idExtraRFk: json["id_extra_r_fk"],
        extraR: Extra.fromMap(json["extra_r"]),
        idExtraDFk: json["id_extra_d_fk"],
        extraD: Extra.fromMap(json["extra_d"]),
        idEquipmentRFk: json["id_equipment_r_fk"],
        equimentR: Equiment.fromMap(json["equiment_r"]),
        idEquipmentDFk: json["id_equipment_d_fk"],
        equimentD: Equiment.fromMap(json["equiment_d"]),
        idBucketInspectionRFk: json["id_bucket_inspection_r_fk"],
        bucketInspectionR:
            BucketInspection.fromMap(json["bucket_inspection_r"]),
        idBucketInspectionDFk: json["id_bucket_inspection_d_fk"],
        bucketInspectionD:
            BucketInspection.fromMap(json["bucket_inspection_d"]),
      );

  Map<String, dynamic> toMap() => {
        "id_vehicle": idVehicle,
        "id_fluids_check_r_fk": idFluidsCheckRFk,
        "fluid_check_r": fluidCheckR.toMap(),
        "id_fluids_check_d_fk": idFluidsCheckDFk,
        "fluid_check_d": fluidCheckD.toMap(),
        "id_lights_r_fk": idLightsRFk,
        "lights_r": lightsR.toMap(),
        "id_lights_d_fk": idLightsDFk,
        "lights_d": lightsD.toMap(),
        "id_car_bodywork_r_fk": idCarBodyworkRFk,
        "car_bodywork_r": Map.from(carBodyworkR)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "id_car_bodywork_d_fk": idCarBodyworkDFk,
        "car_bodywork_d": Map.from(carBodyworkD)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "id_security_r_fk": idSecurityRFk,
        "security_r": securityR.toMap(),
        "id_security_d_fk": idSecurityDFk,
        "security_d": securityD.toMap(),
        "id_extra_r_fk": idExtraRFk,
        "extra_r": extraR.toMap(),
        "id_extra_d_fk": idExtraDFk,
        "extra_d": extraD.toMap(),
        "id_equipment_r_fk": idEquipmentRFk,
        "equiment_r": equimentR.toMap(),
        "id_equipment_d_fk": idEquipmentDFk,
        "equiment_d": equimentD.toMap(),
        "id_bucket_inspection_r_fk": idBucketInspectionRFk,
        "bucket_inspection_r": bucketInspectionR.toMap(),
        "id_bucket_inspection_d_fk": idBucketInspectionDFk,
        "bucket_inspection_d": bucketInspectionD.toMap(),
      };
}

class BucketInspection {
  final int? idBucketInspection;
  final String? insulatedDateclosed;
  final String? holesDrilledDateclosed;
  final String? bucketLinerDateclosed;

  BucketInspection({
    this.idBucketInspection,
    this.insulatedDateclosed,
    this.holesDrilledDateclosed,
    this.bucketLinerDateclosed,
  });

  factory BucketInspection.fromJson(String str) =>
      BucketInspection.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BucketInspection.fromMap(Map<String, dynamic> json) =>
      BucketInspection(
        idBucketInspection: json["id_bucket_inspection"],
        insulatedDateclosed: json["insulated_dateclosed"],
        holesDrilledDateclosed: json["holes_drilled_dateclosed"],
        bucketLinerDateclosed: json["bucket_liner_dateclosed"],
      );

  Map<String, dynamic> toMap() => {
        "id_bucket_inspection": idBucketInspection,
        "insulated_dateclosed": insulatedDateclosed,
        "holes_drilled_dateclosed": holesDrilledDateclosed,
        "bucket_liner_dateclosed": bucketLinerDateclosed,
      };
}

class Equiment {
  final int? idEquipment;
  final dynamic ignitionKeyDateclosed;
  final dynamic binsBoxKeyDateclosed;
  final dynamic vehicleRegistrationCopyDateclosed;
  final dynamic vehicleInsuranceCopyDateclosed;
  final dynamic bucketLiftOperatorManualDateclosed;

  Equiment({
    this.idEquipment,
    this.ignitionKeyDateclosed,
    this.binsBoxKeyDateclosed,
    this.vehicleRegistrationCopyDateclosed,
    this.vehicleInsuranceCopyDateclosed,
    this.bucketLiftOperatorManualDateclosed,
  });

  factory Equiment.fromJson(String str) => Equiment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Equiment.fromMap(Map<String, dynamic> json) => Equiment(
        idEquipment: json["id_equipment"],
        ignitionKeyDateclosed: json["ignition_key_dateclosed"],
        binsBoxKeyDateclosed: json["bins_box_key_dateclosed"],
        vehicleRegistrationCopyDateclosed:
            json["vehicle_registration_copy_dateclosed"],
        vehicleInsuranceCopyDateclosed:
            json["vehicle_insurance_copy_dateclosed"],
        bucketLiftOperatorManualDateclosed:
            json["bucket_lift_operator_manual_dateclosed"],
      );

  Map<String, dynamic> toMap() => {
        "id_equipment": idEquipment,
        "ignition_key_dateclosed": ignitionKeyDateclosed,
        "bins_box_key_dateclosed": binsBoxKeyDateclosed,
        "vehicle_registration_copy_dateclosed":
            vehicleRegistrationCopyDateclosed,
        "vehicle_insurance_copy_dateclosed": vehicleInsuranceCopyDateclosed,
        "bucket_lift_operator_manual_dateclosed":
            bucketLiftOperatorManualDateclosed,
      };
}

class Extra {
  final int? idExtra;
  final dynamic ladderDateclosed;
  final dynamic stepLadderDateclosed;
  final dynamic ladderStrapsDateclosed;
  final dynamic hydraulicFluidForBucketDateclosed;
  final dynamic fiberReelRack;
  final dynamic binsLockedAndSecureDateclosed;
  final dynamic safetyHarness;
  final dynamic lanyardHarnessDateclosed;

  Extra({
    this.idExtra,
    this.ladderDateclosed,
    this.stepLadderDateclosed,
    this.ladderStrapsDateclosed,
    this.hydraulicFluidForBucketDateclosed,
    this.fiberReelRack,
    this.binsLockedAndSecureDateclosed,
    this.safetyHarness,
    this.lanyardHarnessDateclosed,
  });

  factory Extra.fromJson(String str) => Extra.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Extra.fromMap(Map<String, dynamic> json) => Extra(
        idExtra: json["id_extra"],
        ladderDateclosed: json["ladder_dateclosed"],
        stepLadderDateclosed: json["step_ladder_dateclosed"],
        ladderStrapsDateclosed: json["ladder_straps_dateclosed"],
        hydraulicFluidForBucketDateclosed:
            json["hydraulic_fluid_for_bucket_dateclosed"],
        fiberReelRack: json["fiber_reel_rack"],
        binsLockedAndSecureDateclosed:
            json["bins_locked_and_secure_dateclosed"],
        safetyHarness: json["safety_harness"],
        lanyardHarnessDateclosed: json["lanyard_harness_dateclosed"],
      );

  Map<String, dynamic> toMap() => {
        "id_extra": idExtra,
        "ladder_dateclosed": ladderDateclosed,
        "step_ladder_dateclosed": stepLadderDateclosed,
        "ladder_straps_dateclosed": ladderStrapsDateclosed,
        "hydraulic_fluid_for_bucket_dateclosed":
            hydraulicFluidForBucketDateclosed,
        "fiber_reel_rack": fiberReelRack,
        "bins_locked_and_secure_dateclosed": binsLockedAndSecureDateclosed,
        "safety_harness": safetyHarness,
        "lanyard_harness_dateclosed": lanyardHarnessDateclosed,
      };
}

class FluidCheck {
  final int? idFluidsCheck;
  final dynamic engineOilDateclosed;
  final dynamic transmissionDateclosed;
  final dynamic coolantDateclosed;
  final dynamic powerSteeringDateclosed;
  final dynamic dieselExhaustFluidDateclosed;
  final dynamic windshieldWasherFluidDateclosed;

  FluidCheck({
    this.idFluidsCheck,
    this.engineOilDateclosed,
    this.transmissionDateclosed,
    this.coolantDateclosed,
    this.powerSteeringDateclosed,
    this.dieselExhaustFluidDateclosed,
    this.windshieldWasherFluidDateclosed,
  });

  factory FluidCheck.fromJson(String str) =>
      FluidCheck.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FluidCheck.fromMap(Map<String, dynamic> json) => FluidCheck(
        idFluidsCheck: json["id_fluids_check"],
        engineOilDateclosed: json["engine_oil_dateclosed"],
        transmissionDateclosed: json["transmission_dateclosed"],
        coolantDateclosed: json["coolant_dateclosed"],
        powerSteeringDateclosed: json["power_steering_dateclosed"],
        dieselExhaustFluidDateclosed: json["diesel_exhaust_fluid_dateclosed"],
        windshieldWasherFluidDateclosed:
            json["windshield_washer_fluid_dateclosed"],
      );

  Map<String, dynamic> toMap() => {
        "id_fluids_check": idFluidsCheck,
        "engine_oil_dateclosed": engineOilDateclosed,
        "transmission_dateclosed": transmissionDateclosed,
        "coolant_dateclosed": coolantDateclosed,
        "power_steering_dateclosed": powerSteeringDateclosed,
        "diesel_exhaust_fluid_dateclosed": dieselExhaustFluidDateclosed,
        "windshield_washer_fluid_dateclosed": windshieldWasherFluidDateclosed,
      };
}

class Lights {
  final int? idLights;
  final DateTime? headlightsDateclosed;
  final dynamic brakeLightsDateclosed;
  final dynamic reverseLightsDateclosed;
  final dynamic warningLightsDateclosed;
  final dynamic turnSignalsDateclosed;
  final dynamic the4WayFlashersDateclosed;
  final dynamic dashLightsDateclosed;
  final dynamic strobeLightsDateclosed;
  final dynamic cabRoofLightsDateclosed;
  final dynamic clearanceLightsDateclosed;

  Lights({
    this.idLights,
    this.headlightsDateclosed,
    this.brakeLightsDateclosed,
    this.reverseLightsDateclosed,
    this.warningLightsDateclosed,
    this.turnSignalsDateclosed,
    this.the4WayFlashersDateclosed,
    this.dashLightsDateclosed,
    this.strobeLightsDateclosed,
    this.cabRoofLightsDateclosed,
    this.clearanceLightsDateclosed,
  });

  factory Lights.fromJson(String str) => Lights.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Lights.fromMap(Map<String, dynamic> json) => Lights(
        idLights: json["id_lights"],
        headlightsDateclosed: json["headlights_dateclosed"] == null
            ? null
            : DateTime.parse(json["headlights_dateclosed"]),
        brakeLightsDateclosed: json["brake_lights_dateclosed"],
        reverseLightsDateclosed: json["reverse_lights_dateclosed"],
        warningLightsDateclosed: json["warning_lights_dateclosed"],
        turnSignalsDateclosed: json["turn_signals_dateclosed"],
        the4WayFlashersDateclosed: json["4_way_flashers_dateclosed"],
        dashLightsDateclosed: json["dash_lights_dateclosed"],
        strobeLightsDateclosed: json["strobe_lights_dateclosed"],
        cabRoofLightsDateclosed: json["cab_roof_lights_dateclosed"],
        clearanceLightsDateclosed: json["clearance_lights_dateclosed"],
      );

  Map<String, dynamic> toMap() => {
        "id_lights": idLights,
        "headlights_dateclosed": headlightsDateclosed?.toIso8601String(),
        "brake_lights_dateclosed": brakeLightsDateclosed,
        "reverse_lights_dateclosed": reverseLightsDateclosed,
        "warning_lights_dateclosed": warningLightsDateclosed,
        "turn_signals_dateclosed": turnSignalsDateclosed,
        "4_way_flashers_dateclosed": the4WayFlashersDateclosed,
        "dash_lights_dateclosed": dashLightsDateclosed,
        "strobe_lights_dateclosed": strobeLightsDateclosed,
        "cab_roof_lights_dateclosed": cabRoofLightsDateclosed,
        "clearance_lights_dateclosed": clearanceLightsDateclosed,
      };
}

class Security {
  final int? idSecurity;
  final dynamic rtaMagnetDateclosed;
  final dynamic triangleReflectorsDateclosed;
  final dynamic wheelChocksDateclosed;
  final dynamic fireExtinguisherDateclosed;
  final dynamic firstAidKitSafetyVestDateclosed;
  final dynamic backUpAlarmDateclosed;

  Security({
    this.idSecurity,
    this.rtaMagnetDateclosed,
    this.triangleReflectorsDateclosed,
    this.wheelChocksDateclosed,
    this.fireExtinguisherDateclosed,
    this.firstAidKitSafetyVestDateclosed,
    this.backUpAlarmDateclosed,
  });

  factory Security.fromJson(String str) => Security.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Security.fromMap(Map<String, dynamic> json) => Security(
        idSecurity: json["id_security"],
        rtaMagnetDateclosed: json["rta_magnet_dateclosed"],
        triangleReflectorsDateclosed: json["triangle_reflectors_dateclosed"],
        wheelChocksDateclosed: json["wheel_chocks_dateclosed"],
        fireExtinguisherDateclosed: json["fire_extinguisher_dateclosed"],
        firstAidKitSafetyVestDateclosed:
            json["first_aid_kit_safety_vest_dateclosed"],
        backUpAlarmDateclosed: json["back_up_alarm_dateclosed"],
      );

  Map<String, dynamic> toMap() => {
        "id_security": idSecurity,
        "rta_magnet_dateclosed": rtaMagnetDateclosed,
        "triangle_reflectors_dateclosed": triangleReflectorsDateclosed,
        "wheel_chocks_dateclosed": wheelChocksDateclosed,
        "fire_extinguisher_dateclosed": fireExtinguisherDateclosed,
        "first_aid_kit_safety_vest_dateclosed": firstAidKitSafetyVestDateclosed,
        "back_up_alarm_dateclosed": backUpAlarmDateclosed,
      };
}
