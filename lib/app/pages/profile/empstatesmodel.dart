class EmpStateModel {
  List<GetState> getState;

  EmpStateModel({this.getState});

  EmpStateModel.fromJson(Map<String, dynamic> json) {
    if (json['get_state'] != null) {
      getState = new List<GetState>();
      json['get_state'].forEach((v) {
        getState.add(new GetState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getState != null) {
      data['get_state'] = this.getState.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetState {
  int id;
  String stateCode;
  String stateDescription;

  GetState({this.id, this.stateCode, this.stateDescription});

  GetState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateCode = json['state_code'];
    stateDescription = json['state_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_code'] = this.stateCode;
    data['state_description'] = this.stateDescription;
    return data;
  }
}
