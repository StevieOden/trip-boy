class ImageModel {
  ImageModel({
    this.imagesUrl,
  });

  String? imagesUrl;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        imagesUrl: json["image_url"] == null ? "" : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imagesUrl,
      };
}
