import 'package:compe_client/app/data/models/user_model.dart';

class DetailGroupModel {
  String groupId;
  String groupName;
  String groupImg;
  String compeName;
  UserModel leader;
  int maxMember;
  int groupStatus;
  String groupCreatedAt;
  List<UserModel> members;
  int totalMembers;

  DetailGroupModel({
    required this.groupId,
    required this.groupName,
    required this.groupImg,
    required this.compeName,
    required this.leader,
    required this.maxMember,
    required this.groupStatus,
    required this.groupCreatedAt,
    required this.members,
    required this.totalMembers,
  });

  factory DetailGroupModel.fromJson(Map<String, dynamic> json) {
    return DetailGroupModel(
      groupId: json['group']['groupId'].toString(),
      groupName: json['group']['groupName'].toString(),
      groupImg: json['group']['groupImg'].toString(),
      compeName: json['group']['compeName'].toString(),
      leader: UserModel.fromJson(json['group']['leader']),
      maxMember: int.tryParse(json['group']['maxMember'].toString()) ?? 0,
      groupStatus: int.tryParse(json['group']['groupStatus'].toString()) ?? 0,
      groupCreatedAt: json['group']['groupCreatedAt'].toString(),
      members: List<UserModel>.from(
        json['members'].map(
          (v) => UserModel.fromJson(v),
        ),
      ),
      totalMembers: int.tryParse(json['totalMembersInTable'].toString()) ?? 0,
    );
  }
}
