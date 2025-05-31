import 'package:compe_client/app/data/models/all_group_model.dart';
import 'package:compe_client/core/utils/constant.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.data,
    required this.userId,
    required this.onItemTap,
  });
  final AllGroupModel data;
  final String userId;
  final Function() onItemTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(
                (0.1 * 255).round(),
              ),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          spacing: 12,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                data.groupModel.groupImg,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    '${Constant.assetImage}/default.jpg',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Text(
                      data.groupModel.groupName,
                      style: TextStyle(
                        fontFamily: Constant.fontHeading,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Leader : ${data.userModel.userName}',
                      style: TextStyle(
                        fontFamily: Constant.fontContent,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Competition : ${data.compeModel.compeName}',
                      style: TextStyle(
                        fontFamily: Constant.fontContent,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        color: data.groupModel.groupStatus == 0
                            ? Colors.blue
                            : data.groupModel.groupStatus == 1
                                ? Colors.green
                                : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.groupModel.groupStatus == 0
                            ? 'Pending'
                            : data.groupModel.groupStatus == 1
                                ? 'Accepted'
                                : 'Rejected',
                        style: TextStyle(
                          fontFamily: Constant.fontContent,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            userId == data.groupModel.leaderId
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_rounded,
                      size: 24,
                      color: Colors.red,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
