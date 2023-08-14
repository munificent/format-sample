class NumberOfSaleModel {
  int? totalSales;
  List<NumberOfSalesByMissionType>? numberOfSalesByMissionType;

  NumberOfSaleModel({this.totalSales, this.numberOfSalesByMissionType});

  NumberOfSaleModel.fromJson(Map<String, dynamic> json) {
    if (json["totalSales"] is int) this.totalSales = json["totalSales"];
    if (json["numberOfSalesByMissionType"] is List)
      this.numberOfSalesByMissionType =
          json["numberOfSalesByMissionType"] == null
              ? null
              : (json["numberOfSalesByMissionType"] as List).map(
                  (e) => NumberOfSalesByMissionType.fromJson(e),
                ).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalSales"] = this.totalSales;
    if (this.numberOfSalesByMissionType != null)
      data["numberOfSalesByMissionType"] =
          this.numberOfSalesByMissionType?.map((e) => e.toJson()).toList();
    return data;
  }
}

class NumberOfSalesByMissionType {
  int? id;
  String? missionTypeName;
  int? numberOfSales;

  NumberOfSalesByMissionType({
    this.id,
    this.missionTypeName,
    this.numberOfSales,
  });

  NumberOfSalesByMissionType.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["missionTypeName"] is String)
      this.missionTypeName = json["missionTypeName"];
    if (json["numberOfSales"] is int)
      this.numberOfSales = json["numberOfSales"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["missionTypeName"] = this.missionTypeName;
    data["numberOfSales"] = this.numberOfSales;
    return data;
  }
}
