class Facility {
  Facility({
    this.name,
  });

  String? name;

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}