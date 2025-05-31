class GroupModel {
  String groupId;
  String compeId;
  String leaderId;
  String groupName;
  String groupImg;
  int maxMember;
  int groupStatus;
  String? rejectedMessage;

  GroupModel({
    required this.groupId,
    required this.compeId,
    required this.leaderId,
    required this.groupName,
    required this.groupImg,
    required this.maxMember,
    required this.groupStatus,
    required this.rejectedMessage,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['groupId'].toString(),
      compeId: json['compeId'].toString(),
      leaderId: (json['id'] ?? json['uid']).toString(),
      groupName: json['groupName'].toString(),
      groupImg: json['groupImg'].toString(),
      maxMember: int.parse(json['maxMember'].toString()),
      groupStatus: int.parse(json['groupStatus'].toString()),
      rejectedMessage: json['rejectedMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'compeId': compeId,
      'uid': leaderId,
      'groupName': groupName,
      'groupImg': groupImg,
      'maxMember': maxMember,
      'groupStatus': groupStatus,
      'rejectedMessage': rejectedMessage,
    };
  }
}
