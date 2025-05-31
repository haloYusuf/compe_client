import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/data/models/compe_model.dart';
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
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 12,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                data.compeImg,
                height: isAllCompe ? 100 : 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    '${Constant.assetImage}/default.jpg',
                    height: isAllCompe ? 100 : 150,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                spacing: 8,
                children: [
                  Text(
                    data.compeName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: Constant.fontHeading,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Dibuka Sampai : ${data.compeDate}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: Constant.fontContent,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
