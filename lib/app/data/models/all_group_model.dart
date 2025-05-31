import 'package:compe_client/app/data/models/compe_model.dart';
import 'package:compe_client/app/data/models/group_model.dart';
import 'package:compe_client/app/data/models/user_model.dart';

class AllGroupModel {
  CompeModel compeModel;
  GroupModel groupModel;
  UserModel userModel;

  AllGroupModel({
    required this.compeModel,
    required this.groupModel,
    required this.userModel,
  });

  factory AllGroupModel.fromJson(Map<String, dynamic> json) {
    return AllGroupModel(
      compeModel: CompeModel.fromJson(json['groupDetails']['compe']),
      groupModel: GroupModel.fromJson(json['groupDetails']),
      userModel: UserModel.fromJson(json['groupDetails']['user']),
    );
  }
}
