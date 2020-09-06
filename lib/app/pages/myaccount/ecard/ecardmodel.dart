class EcardModel {
  List<McoCardDetail> mcoCardDetail;

  EcardModel({this.mcoCardDetail});

  EcardModel.fromJson(Map<String, dynamic> json) {
    if (json['mco_card_detail'] != null) {
      mcoCardDetail = new List<McoCardDetail>();
      json['mco_card_detail'].forEach((v) {
        mcoCardDetail.add(new McoCardDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mcoCardDetail != null) {
      data['mco_card_detail'] =
          this.mcoCardDetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class McoCardDetail {
  int relationshipCheck;
  String mcoCardNo;
  String planId;
  int policyManagementId;
  String policyName;
  String policyNo;
  String policyType;
  String nricCode;
  String insuranceCompanyName;
  String coverageStartDate;
  String name;

  McoCardDetail(
      {this.relationshipCheck,
      this.mcoCardNo,
      this.planId,
      this.policyManagementId,
      this.policyName,
      this.policyNo,
      this.policyType,
      this.nricCode,
      this.insuranceCompanyName,
      this.coverageStartDate,
      this.name});

  McoCardDetail.fromJson(Map<String, dynamic> json) {
    relationshipCheck = json['relationship_check'];
    mcoCardNo = json['mco_card_no'];
    planId = json['plan_id'];
    policyManagementId = json['policy_management_id'];
    policyName = json['policy_name'];
    policyNo = json['policy_no'];
    policyType = json['policy_type'];
    nricCode = json['nric_code'];
    insuranceCompanyName = json['insurance_company_name'];
    coverageStartDate = json['coverage_start_date'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relationship_check'] = this.relationshipCheck;
    data['mco_card_no'] = this.mcoCardNo;
    data['plan_id'] = this.planId;
    data['policy_management_id'] = this.policyManagementId;
    data['policy_name'] = this.policyName;
    data['policy_no'] = this.policyNo;
    data['policy_type'] = this.policyType;
    data['nric_code'] = this.nricCode;
    data['insurance_company_name'] = this.insuranceCompanyName;
    data['coverage_start_date'] = this.coverageStartDate;
    data['name'] = this.name;
    return data;
  }
}
