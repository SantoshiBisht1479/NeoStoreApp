class AddressModel {
  int id;
  String address;
  String cityLandMark;
  String city;
  String state;
  int zipCode;
  String country;
  AddressModel(
      {this.id,
      this.address,
      this.cityLandMark,
      this.city,
      this.state,
      this.zipCode,
      this.country});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = this.id;
    map['address'] = this.address;
    map['cityLandMark'] = this.cityLandMark;
    map['city'] = this.city;
    map['state'] = this.state;
    map['zipCode'] = this.zipCode;
    map['country'] = this.country;
    return map;
  }

  AddressModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.address = map['address'];
    this.cityLandMark = map['cityLandMark'];
    this.city = map['city'];
    this.state = map['state'];
    this.zipCode = map['zipCode'];
    this.country = map['country'];
  }
}
