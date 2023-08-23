class SplaceResponseModel {
  SplaceResponseModel({
    this.msg,
    this.error,
    this.image,
  });

  String msg;
  bool error;
  String image;

  factory SplaceResponseModel.fromJson(Map<String, dynamic> json) =>
      SplaceResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "image": image == null ? null : image,
      };
}
