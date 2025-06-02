import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/app/data/models/compe_model.dart';
import 'package:flutter/material.dart';

class CompeHomeCard extends StatelessWidget {
  const CompeHomeCard({
    super.key,
    required this.data,
    required this.onTap,
    this.isAllCompe = false,
  });
  final CompeModel data;
  final Function() onTap;
  final bool isAllCompe;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.08 * 255).round()),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withAlpha((0.04 * 255).round()),
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      height: isAllCompe ? 100 : 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey.shade200,
                            Colors.grey.shade100,
                          ],
                        ),
                      ),
                      child: Image.network(
                        data.compeImg,
                        height: isAllCompe ? 100 : 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            '${Constant.assetImage}/default.jpg',
                            height: isAllCompe ? 100 : 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'OPEN',
                        style: TextStyle(
                          fontFamily: Constant.fontHeading,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.green.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.compeName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: Constant.fontHeading,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade800,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.blue.shade100,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              size: 12,
                              color: Colors.blue.shade600,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                data.compeDate,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: Constant.fontContent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} // import 'package:compe_client/core/utils/constant.dart';
// import 'package:compe_client/app/data/models/compe_model.dart';
// import 'package:flutter/material.dart';

// class CompeHomeCard extends StatelessWidget {
//   const CompeHomeCard({
//     super.key,
//     required this.data,
//     required this.onTap,
//     this.isAllCompe = false,
//   });
//   final CompeModel data;
//   final Function() onTap;
//   final bool isAllCompe;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         width: 150,
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
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           spacing: 12,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 topRight: Radius.circular(12),
//               ),
//               child: Image.network(
//                 data.compeImg,
//                 height: isAllCompe ? 100 : 150,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Image.asset(
//                     '${Constant.assetImage}/default.jpg',
//                     height: isAllCompe ? 100 : 150,
//                     fit: BoxFit.cover,
//                   );
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisSize: MainAxisSize.max,
//                 spacing: 8,
//                 children: [
//                   Text(
//                     data.compeName,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontFamily: Constant.fontHeading,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     'Dibuka Sampai : ${data.compeDate}',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontFamily: Constant.fontContent,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
