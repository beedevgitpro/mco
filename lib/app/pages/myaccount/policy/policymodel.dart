class PolicyModel {
  List<GetPolicyDetails> getPolicyDetails;

  PolicyModel({this.getPolicyDetails});

  PolicyModel.fromJson(Map<String, dynamic> json) {
    if (json['get_policy_details'] != null) {
      getPolicyDetails = new List<GetPolicyDetails>();
      json['get_policy_details'].forEach((v) {
        getPolicyDetails.add(new GetPolicyDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getPolicyDetails != null) {
      data['get_policy_details'] =
          this.getPolicyDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPolicyDetails {
  int id;
  String policyNo;
  String policyHolderName;
  String overallLimit;
  String coverageStartDate;
  String coverageEndDate;
  String policyType;
  int isPrincipal;
  int utilisedAmount;
  List<Dependent> dependent;

  GetPolicyDetails(
      {this.id,
      this.policyNo,
      this.policyHolderName,
      this.overallLimit,
      this.coverageStartDate,
      this.coverageEndDate,
      this.policyType,
      this.isPrincipal,
      this.utilisedAmount,
      this.dependent});

  GetPolicyDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policyNo = json['policy_no'];
    policyHolderName = json['policy_holder_name'];
    overallLimit = json['overall_limit'];
    coverageStartDate = json['coverage_start_date'];
    coverageEndDate = json['coverage_end_date'];
    policyType = json['policy_type'];
    isPrincipal = json['is_principal'];
    utilisedAmount = json['utilised_amount'];
    if (json['dependent'] != null) {
      dependent = new List<Dependent>();
      json['dependent'].forEach((v) {
        dependent.add(new Dependent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['policy_no'] = this.policyNo;
    data['policy_holder_name'] = this.policyHolderName;
    data['overall_limit'] = this.overallLimit;
    data['coverage_start_date'] = this.coverageStartDate;
    data['coverage_end_date'] = this.coverageEndDate;
    data['policy_type'] = this.policyType;
    data['is_principal'] = this.isPrincipal;
    data['utilised_amount'] = this.utilisedAmount;
    if (this.dependent != null) {
      data['dependent'] = this.dependent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dependent {
  int id;
  String policyNo;
  String policyHolderName;
  String coverageStartDate;
  String coverageEndDate;
  String policyType;
  int isPrincipal;
  String overallLimit;
  int utilisedAmount;

  Dependent(
      {this.id,
      this.policyNo,
      this.policyHolderName,
      this.coverageStartDate,
      this.coverageEndDate,
      this.policyType,
      this.isPrincipal,
      this.overallLimit,
      this.utilisedAmount});

  Dependent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policyNo = json['policy_no'];
    policyHolderName = json['policy_holder_name'];
    coverageStartDate = json['coverage_start_date'];
    coverageEndDate = json['coverage_end_date'];
    policyType = json['policy_type'];
    isPrincipal = json['is_principal'];
    overallLimit = json['overall_limit'];
    utilisedAmount = json['utilised_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['policy_no'] = this.policyNo;
    data['policy_holder_name'] = this.policyHolderName;
    data['coverage_start_date'] = this.coverageStartDate;
    data['coverage_end_date'] = this.coverageEndDate;
    data['policy_type'] = this.policyType;
    data['is_principal'] = this.isPrincipal;
    data['overall_limit'] = this.overallLimit;
    data['utilised_amount'] = this.utilisedAmount;
    return data;
  }
}
