import 'package:compe_client/app/data/models/all_group_model.dart';
import 'package:compe_client/core/utils/constant.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.data,
    required this.userId,
    required this.onItemTap,
    required this.onEditTap,
  });
  final AllGroupModel data;
  final String userId;
  final Function() onItemTap;
  final Function() onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: onItemTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: IntrinsicHeight(
              // This makes the row adapt to the tallest child
              child: Row(
                children: [
                  // Image Section
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: SizedBox(
                      width: 110,
                      child: Image.network(
                        data.groupModel.groupImg,
                        width: 110,
                        fit: BoxFit
                            .cover, // This will cover the entire available height
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            '${Constant.assetImage}/default.jpg',
                            width: 110,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),

                  // Content Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Distribute content evenly
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Group Name
                              Text(
                                data.groupModel.groupName,
                                style: TextStyle(
                                  fontFamily: Constant.fontHeading,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1F2937),
                                  letterSpacing: 0.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),

                              // Leader Info
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 14,
                                      color: Colors.blue.shade600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Leader: ${data.userModel.userName}',
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF6B7280),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // Competition Info
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(
                                      Icons.emoji_events,
                                      size: 14,
                                      color: Colors.orange.shade600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      data.compeModel.compeName,
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF6B7280),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Status and Edit Button Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: data.groupModel.groupStatus == 0
                                        ? [
                                            Colors.blue.shade400,
                                            Colors.blue.shade600
                                          ]
                                        : data.groupModel.groupStatus == 1
                                            ? [
                                                Colors.green.shade400,
                                                Colors.green.shade600
                                              ]
                                            : [
                                                Colors.red.shade400,
                                                Colors.red.shade600
                                              ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (data.groupModel.groupStatus == 0
                                              ? Colors.blue
                                              : data.groupModel.groupStatus == 1
                                                  ? Colors.green
                                                  : Colors.red)
                                          .withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
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
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),

                              // Edit Button
                              if (userId == data.groupModel.leaderId)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: onEditTap,
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      size: 20,
                                      color: Colors.grey.shade700,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:compe_client/app/data/models/all_group_model.dart';
// import 'package:compe_client/core/utils/constant.dart';
// import 'package:flutter/material.dart';

// class GroupCard extends StatelessWidget {
//   const GroupCard({
//     super.key,
//     required this.data,
//     required this.userId,
//     required this.onItemTap,
//     required this.onEditTap,
//   });
//   final AllGroupModel data;
//   final String userId;
//   final Function() onItemTap;
//   final Function() onEditTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onItemTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withAlpha(
//                 (0.1 * 255).round(),
//               ),
//               spreadRadius: 0,
//               blurRadius: 4,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           spacing: 12,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 bottomLeft: Radius.circular(12),
//               ),
//               child: Image.network(
//                 data.groupModel.groupImg,
//                 height: 100,
//                 width: 100,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Image.asset(
//                     '${Constant.assetImage}/default.jpg',
//                     height: 100,
//                     width: 100,
//                     fit: BoxFit.cover,
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 2,
//                   children: [
//                     Text(
//                       data.groupModel.groupName,
//                       style: TextStyle(
//                         fontFamily: Constant.fontHeading,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       'Leader : ${data.userModel.userName}',
//                       style: TextStyle(
//                         fontFamily: Constant.fontContent,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Text(
//                       'Competition : ${data.compeModel.compeName}',
//                       style: TextStyle(
//                         fontFamily: Constant.fontContent,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 2,
//                         horizontal: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: data.groupModel.groupStatus == 0
//                             ? Colors.blue
//                             : data.groupModel.groupStatus == 1
//                                 ? Colors.green
//                                 : Colors.red,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         data.groupModel.groupStatus == 0
//                             ? 'Pending'
//                             : data.groupModel.groupStatus == 1
//                                 ? 'Accepted'
//                                 : 'Rejected',
//                         style: TextStyle(
//                           fontFamily: Constant.fontContent,
//                           fontSize: 12,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             userId == data.groupModel.leaderId
//                 ? IconButton(
//                     onPressed: onEditTap,
//                     icon: Icon(
//                       Icons.edit,
//                       size: 24,
//                       color: Colors.black,
//                     ),
//                   )
//                 : SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }
