class CompeModel {
  String compeId;
  String compeName;
  String compeDesc;
  String compeDate;
  String compeImg;
  int compeStatus;
  int maxParticipant;
  String createdAt;

  CompeModel({
    required this.compeId,
    required this.compeName,
    required this.compeDesc,
    required this.compeDate,
    required this.compeImg,
    required this.compeStatus,
    required this.maxParticipant,
    required this.createdAt,
  });

  factory CompeModel.fromJson(Map<String, dynamic> json) {
    return CompeModel(
      compeId: json['compeId'].toString(),
      compeName: json['compeName'].toString(),
      compeDesc: json['compeDesc'].toString(),
      compeDate: json['compeDate'].toString(),
      compeImg: json['compeImg'].toString(),
      compeStatus: int.parse(json['compeStatus'].toString()),
      maxParticipant: int.parse(json['maxParticipant'].toString()),
      createdAt: json['createdAt'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compeId': compeId,
      'compeName': compeName,
      'compeDesc': compeDesc,
      'compeDate': compeDate,
      'compeImg': compeImg,
      'compeStatus': compeStatus,
      'maxParticipant': maxParticipant,
      'createdAt': createdAt,
    };
  }
}
