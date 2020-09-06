class ClaimsModel {
  List<GetClaims> getClaims;

  ClaimsModel({this.getClaims});

  ClaimsModel.fromJson(Map<String, dynamic> json) {
    if (json['get_claims'] != null) {
      getClaims = new List<GetClaims>();
      json['get_claims'].forEach((v) {
        getClaims.add(new GetClaims.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getClaims != null) {
      data['get_claims'] = this.getClaims.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetClaims {
  int id;
  int caseId;
  int isPrincipal;
  String name;
  String admissionDate;
  int approvedAmount;
  int engagedAmount;

  GetClaims(
      {this.id,
      this.caseId,
      this.isPrincipal,
      this.name,
      this.admissionDate,
      this.approvedAmount,
      this.engagedAmount});

  GetClaims.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseId = json['case_id'];
    isPrincipal = json['is_principal'];
    name = json['name'];
    admissionDate = json['admission_date'];
    approvedAmount = json['approved_amount'];
    engagedAmount = json['engaged_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['case_id'] = this.caseId;
    data['is_principal'] = this.isPrincipal;
    data['name'] = this.name;
    data['admission_date'] = this.admissionDate;
    data['approved_amount'] = this.approvedAmount;
    data['engaged_amount'] = this.engagedAmount;
    return data;
  }
}
