import 'dart:convert';

class Role {
  Role({
    required this.id,
    required this.roleName,
    required this.permissions,
    required this.application,
  });

  int id;
  String roleName;
  Permissions permissions;
  String application;

  String get roleApplication => '$application -  $roleName';

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"] ?? json['role_id'],
        roleName: json["name"],
        permissions: Permissions.fromMap(json["permissions"]),
        application: json['application'],
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Role && other.roleName == roleName && other.id == id;
  }

  @override
  int get hashCode => Object.hash(roleName, id, permissions);
}

class Permissions {
  //WOP
  String? prospects;
  String? scheduling;
  String? network;
  String? tickets;
  String? order;
  String? campaigns;
  String? reports;
  //FMT
  String? users;
  String? inventory;
  String? dashboards;
  String? configuratorSm;
  String? vehicleStatus;
  String? downloadApk;
  //Dashboards RTATEL
  String? fmt;
  String? wop;
  String? sales;
  String? manager;
  String? surveys;
  String? ivrStats;
  String? callCenter;
  String? configurator;
  String? ecommerceRta;
  String? homeownerFTTHDocument;
  String? jobComplete;
  String? mapCoverage;
  String? engageOption;
  String? iptvTracking;
  String? jobsTracking;
  String? monthlyChurn;
  String? voipTracking;
  String? gigFastNetwork;
  String? jobCompleteCry;
  String? jobCompleteEas;
  String? jobCompleteOde;
  String? jobCompleteSmi;
  String? jobCompleteIncentives;
  String? operationReport;
  String? deactContactLog;
  String? noCoverageLeads;
  String? configuratorStats;
  String? referralsTracking;
  String? conversionRate;
  String? monitoringDashboard;
  String? itSurveyOctober2021;
  String? newConfiguratorStats;
  String? techJobTimeTracking;
  String? jobCompletedServiceOverall;
  String? jobsUtilizationTracking;
  String? arpuTrackingWholesale;
  String? opCoSubscriberTargets;
  String? jobCompleteTechnicians;
  String? wispapalooza2021Survey;
  String? arpuTrackingResidential;
  String? wirelessFiberCustomers;
  String? newSalesTrackingDashboard;
  String? monthlyArpuTrackingWholesale;
  String? monthlyArpuTrackingResidential;
  String? residentialAndBusinessCustomers;
  String? bolivarPeninsulaFiberToTheHome;

  Permissions(
      {
      //WOP
      required this.prospects,
      required this.scheduling,
      required this.network,
      required this.tickets,
      required this.order,
      required this.campaigns,
      required this.reports,
      //FMT
      required this.users,
      required this.inventory,
      required this.dashboards,
      required this.configuratorSm,
      required this.vehicleStatus,
      required this.downloadApk,
      //Dashboards RTATEL
      required this.fmt,
      required this.wop,
      required this.sales,
      required this.manager,
      required this.surveys,
      required this.ivrStats,
      required this.callCenter,
      required this.configurator,
      required this.ecommerceRta,
      required this.homeownerFTTHDocument,
      required this.jobComplete,
      required this.mapCoverage,
      required this.engageOption,
      required this.iptvTracking,
      required this.jobsTracking,
      required this.monthlyChurn,
      required this.voipTracking,
      required this.gigFastNetwork,
      required this.jobCompleteCry,
      required this.jobCompleteEas,
      required this.jobCompleteOde,
      required this.jobCompleteSmi,
      required this.operationReport,
      required this.deactContactLog,
      required this.noCoverageLeads,
      required this.configuratorStats,
      required this.referralsTracking,
      required this.conversionRate,
      required this.monitoringDashboard,
      required this.itSurveyOctober2021,
      required this.newConfiguratorStats,
      required this.techJobTimeTracking,
      required this.arpuTrackingWholesale,
      required this.jobCompleteIncentives,
      required this.opCoSubscriberTargets,
      required this.jobCompleteTechnicians,
      required this.wispapalooza2021Survey,
      required this.arpuTrackingResidential,
      required this.jobsUtilizationTracking,
      required this.wirelessFiberCustomers,
      required this.newSalesTrackingDashboard,
      required this.jobCompletedServiceOverall,
      required this.monthlyArpuTrackingWholesale,
      required this.monthlyArpuTrackingResidential,
      required this.residentialAndBusinessCustomers,
      required this.bolivarPeninsulaFiberToTheHome});

  factory Permissions.fromJson(String str) =>
      Permissions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permissions.fromMap(Map<String, dynamic> json) => Permissions(
        //WOP
        prospects: json["Prospects"],
        scheduling: json["Scheduling"],
        network: json["Network"],
        tickets: json["Tickets"],
        order: json["Order"],
        campaigns: json["Campaigns"],
        reports: json["Reports"],
        //FMT
        users: json["Users"],
        inventory: json["Inventory"],
        dashboards: json["Dashboards"],
        configuratorSm: json["Configurator SM"],
        vehicleStatus: json["Vehicle Status"],
        downloadApk: json["Download APK"],
        //Dashboards RTATEL
        fmt: json["FMT"],
        wop: json["WOP"],
        sales: json["Sales"],
        manager: json["Manager"],
        surveys: json["Surveys"],
        ivrStats: json["IVR Stats"],
        callCenter: json["Call Center"],
        configurator: json["Configurator"],
        ecommerceRta: json["EcommerceRTA"],
        homeownerFTTHDocument: json["Homeowner FTTH Document"],
        jobComplete: json["Job Complete"],
        mapCoverage: json["Map Coverage"],
        engageOption: json["Engage Option"],
        iptvTracking: json["IPTV Tracking"],
        jobsTracking: json["Jobs Tracking"],
        monthlyChurn: json["Monthly Churn"],
        voipTracking: json["VOIP Tracking"],
        gigFastNetwork: json["GigFast Network"],
        jobCompleteCry: json["Job Complete CRY"],
        jobCompleteEas: json["Job Complete EAS"],
        jobCompleteOde: json["Job Complete ODE"],
        jobCompleteSmi: json["Job Complete SMI"],
        operationReport: json["Operation Report"],
        deactContactLog: json["Deact Contact Log"],
        noCoverageLeads: json["No Coverage Leads"],
        configuratorStats: json["Configurator Stats"],
        referralsTracking: json["Referrals Tracking"],
        conversionRate: json["Conversion rate"],
        monitoringDashboard: json["Monitoring Dashboard"],
        itSurveyOctober2021: json["IT Survey October 2021"],
        newConfiguratorStats: json["New Configurator Stats"],
        techJobTimeTracking: json["Tech Job Time Tracking"],
        arpuTrackingWholesale: json["ARPU Tracking Wholesale"],
        jobCompleteIncentives: json["Job Complete Incentives"],
        opCoSubscriberTargets: json["OpCo Subscriber Targets"],
        jobCompleteTechnicians: json["Job Complete Technicians"],
        wispapalooza2021Survey: json["WISPAPALOOZA 2021 Survey"],
        arpuTrackingResidential: json["ARPU Tracking Residential"],
        jobsUtilizationTracking: json["Jobs Utilization Tracking"],
        wirelessFiberCustomers: json["Wireless & Fiber Customers"],
        newSalesTrackingDashboard: json["New Sales Tracking Dashboard"],
        jobCompletedServiceOverall: json["Job Completed Service Overall"],
        monthlyArpuTrackingWholesale: json["Monthly ARPU Tracking Wholesale"],
        monthlyArpuTrackingResidential:
            json["Monthly ARPU Tracking Residential"],
        residentialAndBusinessCustomers:
            json["Residential and Business Customers"],
        bolivarPeninsulaFiberToTheHome:
            json["Bolivar Peninsula Fiber to the Home"],
      );

  Map<String, dynamic> toMap() => {
        //WOP
        "Prospects": prospects,
        "Scheduling": scheduling,
        "Newtork": network,
        "Tickets": tickets,
        "Order": order,
        "Campaigns": campaigns,
        "Reports": reports,
        //FMT
        "Users": users,
        "Inventory": inventory,
        "Dashboards": dashboards,
        "Configurator SM": configuratorSm,
        "Vehicle Status": vehicleStatus,
        "Download APK": downloadApk,
        //Dashboards RTATEL
        "FMT": fmt,
        "WOP": wop,
        "Sales": sales,
        "Manager": manager,
        "Surveys": surveys,
        "IVR Stats": ivrStats,
        "Call Center": callCenter,
        "Configurator": configurator,
        "EcommerceRTA": ecommerceRta,
        "Homeowner FTTH Document": homeownerFTTHDocument,
        "Job Complete": jobComplete,
        "Map Coverage": mapCoverage,
        "Engage Option": engageOption,
        "IPTV Tracking": iptvTracking,
        "Jobs Tracking": jobsTracking,
        "Monthly Churn": monthlyChurn,
        "VOIP Tracking": voipTracking,
        "GigFast Network": gigFastNetwork,
        "Job Complete CRY": jobCompleteCry,
        "Job Complete EAS": jobCompleteEas,
        "Job Complete ODE": jobCompleteOde,
        "Job Complete SMI": jobCompleteSmi,
        "Operation Report": operationReport,
        "Deact Contact Log": deactContactLog,
        "No Coverage Leads": noCoverageLeads,
        "Configurator Stats": configuratorStats,
        "Referrals Tracking": referralsTracking,
        "Conversion rate": conversionRate,
        "Monitoring Dashboard": monitoringDashboard,
        "IT Survey October 2021": itSurveyOctober2021,
        "New Configurator Stats": newConfiguratorStats,
        "Tech Job Time Tracking": techJobTimeTracking,
        "ARPU Tracking Wholesale": arpuTrackingWholesale,
        "Job Complete Incentives": jobCompleteIncentives,
        "OpCo Subscriber Targets": opCoSubscriberTargets,
        "Job Complete Technicians": jobCompleteTechnicians,
        "WISPAPALOOZA 2021 Survey": wispapalooza2021Survey,
        "ARPU Tracking Residential": arpuTrackingResidential,
        "Jobs Utilization Tracking": jobsUtilizationTracking,
        "Wireless & Fiber Customers": wirelessFiberCustomers,
        "New Sales Tracking Dashboard": newSalesTrackingDashboard,
        "Job Completed Service Overall": jobCompletedServiceOverall,
        "Monthly ARPU Tracking Wholesale": monthlyArpuTrackingWholesale,
        "Monthly ARPU Tracking Residential": monthlyArpuTrackingResidential,
        "Residential and Business Customers": residentialAndBusinessCustomers,
        "Bolivar Peninsula Fiber to the Home": bolivarPeninsulaFiberToTheHome,
      };
}
