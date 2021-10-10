class Secuirty{
  String SecuirtyID;

  Secuirty({this.SecuirtyID});

  Secuirty.fromJson(Map<String, dynamic> json) {
    SecuirtyID = json['SecuirtyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SecuirtyID'] = this.SecuirtyID;
    return data;
  }
}
