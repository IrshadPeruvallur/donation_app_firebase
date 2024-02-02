class DonorModel {
  String? name;
  int? age;
  String? group;
  int? phone;
  String? image;
  DonorModel(
      {required this.age,
      required this.group,
      required this.name,
      required this.phone,
      required this.image});

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
        age: json['age'],
        group: json['group'],
        name: json['name'],
        phone: json['phone'],
        image: json['image']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'group': group,
      'phone': phone,
      'image': image
    };
  }
}
