class BaseModel {
  Map<String, dynamic>? basejson;

  Map<String, dynamic> toJson() {
    return basejson!;
  }

  BaseModel.fromJson(Map<String, dynamic> json) {
    basejson = json;
  }
}
