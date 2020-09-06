class EmpNationalityModel {
  List<GetNationality> getNationality;

  EmpNationalityModel({this.getNationality});

  EmpNationalityModel.fromJson(Map<String, dynamic> json) {
    if (json['get_nationality'] != null) {
      getNationality = new List<GetNationality>();
      json['get_nationality'].forEach((v) {
        getNationality.add(new GetNationality.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getNationality != null) {
      data['get_nationality'] =
          this.getNationality.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetNationality {
  int id;
  String code;
  String description;

  GetNationality({this.id, this.code, this.description});

  GetNationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}
