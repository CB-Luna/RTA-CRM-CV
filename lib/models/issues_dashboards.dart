import 'dart:convert';

class IssuesDashboards {
    final int idControlForm;
    final int idVehicle;
    final String licensePlates;
    final String company;
    final int issuesR;
    final int? issuesD;
    final DateTime dateAddedR;
    final DateTime? dateAddedD;
    final UserProfile userProfile;
    final BucketInspection bucketInspectionR;
    final BucketInspection bucketInspectionD;
    final CarBodywork carBodyworkR;
    final CarBodywork carBodyworkD;
    final Equipment equipmentR;
    final Equipment equipmentD;
    final Extra extraR;
    final Extra extraD;
    final FluidCheck fluidCheckR;
    final FluidCheck fluidCheckD;
    final Lights lightsR;
    final Lights lightsD;
    final Security securityR;
    final Security securityD;

    IssuesDashboards({
        required this.idControlForm,
        required this.idVehicle,
        required this.licensePlates,
        required this.company,
        required this.issuesR,
        this.issuesD,
        required this.dateAddedR,
        this.dateAddedD,
        required this.userProfile,
        required this.bucketInspectionR,
        required this.bucketInspectionD,
        required this.carBodyworkR,
        required this.carBodyworkD,
        required this.equipmentR,
        required this.equipmentD,
        required this.extraR,
        required this.extraD,
        required this.fluidCheckR,
        required this.fluidCheckD,
        required this.lightsR,
        required this.lightsD,
        required this.securityR,
        required this.securityD,
    });

    factory IssuesDashboards.fromJson(String str) => IssuesDashboards.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory IssuesDashboards.fromMap(Map<String, dynamic> json) => IssuesDashboards(
        idControlForm: json["id_control_form"],
        idVehicle: json["id_vehicle"],
        licensePlates: json["license_plates"],
        company: json["company"],
        issuesR: json["issues_r"],
        issuesD: json["issues_d"],
        dateAddedR: DateTime.parse(json["date_added_r"]),
        dateAddedD: json["date_added_d"] == null ? null : DateTime.parse(json["date_added_d"]),
        userProfile: UserProfile.fromMap(json["user_profile"]),
        bucketInspectionR: BucketInspection.fromMap(json["bucket_inspection_r"]),
        bucketInspectionD: BucketInspection.fromMap(json["bucket_inspection_d"]),
        carBodyworkR: CarBodywork.fromMap(json["car_bodywork_r"]),
        carBodyworkD: CarBodywork.fromMap(json["car_bodywork_d"]),
        equipmentR: Equipment.fromMap(json["equipment_r"]),
        equipmentD: Equipment.fromMap(json["equipment_d"]),
        extraR: Extra.fromMap(json["extra_r"]),
        extraD: Extra.fromMap(json["extra_d"]),
        fluidCheckR: FluidCheck.fromMap(json["fluid_check_r"]),
        fluidCheckD: FluidCheck.fromMap(json["fluid_check_d"]),
        lightsR: Lights.fromMap(json["lights_r"]),
        lightsD: Lights.fromMap(json["lights_d"]),
        securityR: Security.fromMap(json["security_r"]),
        securityD: Security.fromMap(json["security_d"]),
    );

    Map<String, dynamic> toMap() => {
        "id_control_form": idControlForm,
        "id_vehicle": idVehicle,
        "license_plates": licensePlates,
        "company": company,
        "issues_r": issuesR,
        "issues_d": issuesD,
        "date_added_r": dateAddedR.toIso8601String(),
        "date_added_d": dateAddedD?.toIso8601String(),
        "user_profile": userProfile.toMap(),
        "bucket_inspection_r": bucketInspectionR.toMap(),
        "bucket_inspection_d": bucketInspectionD.toMap(),
        "car_bodywork_r": carBodyworkR.toMap(),
        "car_bodywork_d": carBodyworkD.toMap(),
        "equipment_r": equipmentR.toMap(),
        "equipment_d": equipmentD.toMap(),
        "extra_r": extraR.toMap(),
        "extra_d": extraD.toMap(),
        "fluid_check_r": fluidCheckR.toMap(),
        "fluid_check_d": fluidCheckD.toMap(),
        "lights_r": lightsR.toMap(),
        "lights_d": lightsD.toMap(),
        "security_r": securityR.toMap(),
        "security_d": securityD.toMap(),
    };
}

class BucketInspection {
    final int? idBucketInspection;
    final bool? insulated;
    final bool? holesDrilled;
    final bool? bucketLiner;
    final DateTime? dateAdded;

    BucketInspection({
      this.idBucketInspection,
      this.insulated,
      this.holesDrilled,
      this.bucketLiner,
      this.dateAdded,
    });

    factory BucketInspection.fromJson(String str) => BucketInspection.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory BucketInspection.fromMap(Map<String, dynamic> json) => BucketInspection(
        idBucketInspection: json["id_bucket_inspection"],
        insulated: json["insulated"],
        holesDrilled: json["holes_drilled"],
        bucketLiner: json["bucket_liner"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_bucket_inspection": idBucketInspection,
        "insulated": insulated,
        "holes_drilled": holesDrilled,
        "bucket_liner": bucketLiner,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class CarBodywork {
    final int? idCarBodywork;
    final bool? wiperBladesFront;
    final bool? wiperBladesBack;
    final bool? windshieldWiperFront;
    final bool? windshieldWiperBack;
    final bool? generalBody;
    final bool? decaling;
    final bool? tires;
    final bool? glass;
    final bool? mirrors;
    final bool? parking;
    final bool? brakes;
    final bool? emgBrakes;
    final bool? horn;
    final DateTime? dateAdded;

    CarBodywork({
      this.idCarBodywork,
      this.wiperBladesFront,
      this.wiperBladesBack,
      this.windshieldWiperFront,
      this.windshieldWiperBack,
      this.generalBody,
      this.decaling,
      this.tires,
      this.glass,
      this.mirrors,
      this.parking,
      this.brakes,
      this.emgBrakes,
      this.horn,
      this.dateAdded,
    });

    factory CarBodywork.fromJson(String str) => CarBodywork.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CarBodywork.fromMap(Map<String, dynamic> json) => CarBodywork(
        idCarBodywork: json["id_car_bodywork"],
        wiperBladesFront: json["wiper_blades_front"],
        wiperBladesBack: json["wiper_blades_back"],
        windshieldWiperFront: json["windshield_wiper_front"],
        windshieldWiperBack: json["windshield_wiper_back"],
        generalBody: json["general_body"],
        decaling: json["decaling"],
        tires: json["tires"],
        glass: json["glass"],
        mirrors: json["mirrors"],
        parking: json["parking"],
        brakes: json["brakes"],
        emgBrakes: json["emg_brakes"],
        horn: json["horn"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_car_bodywork": idCarBodywork,
        "wiper_blades_front": wiperBladesFront,
        "wiper_blades_back": wiperBladesBack,
        "windshield_wiper_front": windshieldWiperFront,
        "windshield_wiper_back": windshieldWiperBack,
        "general_body": generalBody,
        "decaling": decaling,
        "tires": tires,
        "glass": glass,
        "mirrors": mirrors,
        "parking": parking,
        "brakes": brakes,
        "emg_brakes": emgBrakes,
        "horn": horn,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class Equipment {
    final int? idEquipment;
    final bool? ignitionKey;
    final bool? binsBoxKey;
    final bool? vehicleRegistrationCopy;
    final bool? vehicleInsuranceCopy;
    final bool? bucketLiftOperatorManual;
    final DateTime? dateAdded;

    Equipment({
      this.idEquipment,
      this.ignitionKey,
      this.binsBoxKey,
      this.vehicleRegistrationCopy,
      this.vehicleInsuranceCopy,
      this.bucketLiftOperatorManual,
      this.dateAdded,
    });

    factory Equipment.fromJson(String str) => Equipment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Equipment.fromMap(Map<String, dynamic> json) => Equipment(
        idEquipment: json["id_equipment"],
        ignitionKey: json["ignition_key"],
        binsBoxKey: json["bins_box_key"],
        vehicleRegistrationCopy: json["vehicle_registration_copy"],
        vehicleInsuranceCopy: json["vehicle_insurance_copy"],
        bucketLiftOperatorManual: json["bucket_lift_operator_manual"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_equipment": idEquipment,
        "ignition_key": ignitionKey,
        "bins_box_key": binsBoxKey,
        "vehicle_registration_copy": vehicleRegistrationCopy,
        "vehicle_insurance_copy": vehicleInsuranceCopy,
        "bucket_lift_operator_manual": bucketLiftOperatorManual,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class Extra {
    final int? idExtra;
    final bool? ladder;
    final bool? stepLadder;
    final bool? ladderStraps;
    final bool? hydraulicFluidForBucket;
    final bool? fiberReelRack;
    final bool? binsLockedAndSecure;
    final bool? safetyHarness;
    final bool? lanyardSafetyHarness;
    final DateTime? dateAdded;

    Extra({
      this.idExtra,
      this.ladder,
      this.stepLadder,
      this.ladderStraps,
      this.hydraulicFluidForBucket,
      this.fiberReelRack,
      this.binsLockedAndSecure,
      this.safetyHarness,
      this.lanyardSafetyHarness,
      this.dateAdded,
    });

    factory Extra.fromJson(String str) => Extra.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Extra.fromMap(Map<String, dynamic> json) => Extra(
        idExtra: json["id_extra"],
        ladder: json["ladder"],
        stepLadder: json["step_ladder"],
        ladderStraps: json["ladder_straps"],
        hydraulicFluidForBucket: json["hydraulic_fluid_for_bucket"],
        fiberReelRack: json["fiber_reel_rack"],
        binsLockedAndSecure: json["bins_locked_and_secure"],
        safetyHarness: json["safety_harness"],
        lanyardSafetyHarness: json["lanyard_safety_harness"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_extra": idExtra,
        "ladder": ladder,
        "step_ladder": stepLadder,
        "ladder_straps": ladderStraps,
        "hydraulic_fluid_for_bucket": hydraulicFluidForBucket,
        "fiber_reel_rack": fiberReelRack,
        "bins_locked_and_secure": binsLockedAndSecure,
        "safety_harness": safetyHarness,
        "lanyard_safety_harness": lanyardSafetyHarness,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class FluidCheck {
    final int? idFluidsCheck;
    final bool? engineOil;
    final bool? transmission;
    final bool? coolant;
    final bool? powerSteering;
    final bool? dieselExhaustFluid;
    final bool? windshieldWasherFluid;
    final DateTime? dateAdded;

    FluidCheck({
      this.idFluidsCheck,
      this.engineOil,
      this.transmission,
      this.coolant,
      this.powerSteering,
      this.dieselExhaustFluid,
      this.windshieldWasherFluid,
      this.dateAdded,
    });

    factory FluidCheck.fromJson(String str) => FluidCheck.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FluidCheck.fromMap(Map<String, dynamic> json) => FluidCheck(
        idFluidsCheck: json["id_fluids_check"],
        engineOil: json["engine_oil"],
        transmission: json["transmission"],
        coolant: json["coolant"],
        powerSteering: json["power_steering"],
        dieselExhaustFluid: json["diesel_exhaust_fluid"],
        windshieldWasherFluid: json["windshield_washer_fluid"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_fluids_check": idFluidsCheck,
        "engine_oil": engineOil,
        "transmission": transmission,
        "coolant": coolant,
        "power_steering": powerSteering,
        "diesel_exhaust_fluid": dieselExhaustFluid,
        "windshield_washer_fluid": windshieldWasherFluid,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class Lights {
    final int? idLights;
    final bool? headlights;
    final bool? brakeLights;
    final bool? reverseLights;
    final bool? warningLights;
    final bool? turnSignals;
    final bool? the4WayFlashers;
    final bool? dashLights;
    final bool? strobeLights;
    final bool? cabRoofLights;
    final bool? clearanceLights;
    final DateTime? dateAdded;

    Lights({
      this.idLights,
      this.headlights,
      this.brakeLights,
      this.reverseLights,
      this.warningLights,
      this.turnSignals,
      this.the4WayFlashers,
      this.dashLights,
      this.strobeLights,
      this.cabRoofLights,
      this.clearanceLights,
      this.dateAdded,
    });

    factory Lights.fromJson(String str) => Lights.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Lights.fromMap(Map<String, dynamic> json) => Lights(
        idLights: json["id_lights"],
        headlights: json["headlights"],
        brakeLights: json["brake_lights"],
        reverseLights: json["reverse_lights"],
        warningLights: json["warning_lights"],
        turnSignals: json["turn_signals"],
        the4WayFlashers: json["4_way_flashers"],
        dashLights: json["dash_lights"],
        strobeLights: json["strobe_lights"],
        cabRoofLights: json["cab_roof_lights"],
        clearanceLights: json["clearance_lights"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_lights": idLights,
        "headlights": headlights,
        "brake_lights": brakeLights,
        "reverse_lights": reverseLights,
        "warning_lights": warningLights,
        "turn_signals": turnSignals,
        "4_way_flashers": the4WayFlashers,
        "dash_lights": dashLights,
        "strobe_lights": strobeLights,
        "cab_roof_lights": cabRoofLights,
        "clearance_lights": clearanceLights,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class Security {
    final int? idSecurity;
    final bool? rtaMagnet;
    final bool? triangleReflectors;
    final bool? wheelChocks;
    final bool? fireExtinguisher;
    final bool? firstAidKitSafetyVest;
    final bool? backUpAlarm;
    final DateTime? dateAdded;

    Security({
      this.idSecurity,
      this.rtaMagnet,
      this.triangleReflectors,
      this.wheelChocks,
      this.fireExtinguisher,
      this.firstAidKitSafetyVest,
      this.backUpAlarm,
      this.dateAdded,
    });

    factory Security.fromJson(String str) => Security.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Security.fromMap(Map<String, dynamic> json) => Security(
        idSecurity: json["id_security"],
        rtaMagnet: json["rta_magnet"],
        triangleReflectors: json["triangle_reflectors"],
        wheelChocks: json["wheel_chocks"],
        fireExtinguisher: json["fire_extinguisher"],
        firstAidKitSafetyVest: json["first_aid_kit_safety_vest"],
        backUpAlarm: json["back_up_alarm"],
        dateAdded: json["date_added"] == null ? null : DateTime.parse(json["date_added"]),
    );

    Map<String, dynamic> toMap() => {
        "id_security": idSecurity,
        "rta_magnet": rtaMagnet,
        "triangle_reflectors": triangleReflectors,
        "wheel_chocks": wheelChocks,
        "fire_extinguisher": fireExtinguisher,
        "first_aid_kit_safety_vest": firstAidKitSafetyVest,
        "back_up_alarm": backUpAlarm,
        "date_added": dateAdded?.toIso8601String(),
    };
}

class UserProfile {
    final String idUserFk;
    final String name;
    final String lastName;
    final String? middleName;
    final int sequentialId;

    UserProfile({
        required this.idUserFk,
        required this.name,
        required this.lastName,
        this.middleName,
        required this.sequentialId,
    });

    factory UserProfile.fromJson(String str) => UserProfile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserProfile.fromMap(Map<String, dynamic> json) => UserProfile(
        idUserFk: json["id_user_fk"],
        name: json["name"],
        lastName: json["last_name"],
        middleName: json["middle_name"],
        sequentialId: json["sequential_id"],
    );

    Map<String, dynamic> toMap() => {
        "id_user_fk": idUserFk,
        "name": name,
        "last_name": lastName,
        "middle_name": middleName,
        "sequential_id": sequentialId,
    };
}


