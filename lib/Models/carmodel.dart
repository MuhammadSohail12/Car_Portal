class CarModel {
  int? id;
  late String make;
  late String color;
  late String model;
  late String registerationNumber;

  CarModel(
       this.make, this.color, this.model, this.registerationNumber);

  CarModel.fromMap(Map<String, dynamic> map) {

    make = map['make'];
    color = map['color'];
    model = map['model'];

    registerationNumber = map['registerationNumber'];
  }

  Map<String, dynamic> toMap() {
    return {
      'make': make,
      'color': color,
      'model': model,
      'registerationNumber': registerationNumber
    };
  }
}
