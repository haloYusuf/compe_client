import 'package:compe_client/app/data/models/detail_group_model.dart';
import 'package:flutter/material.dart';

class MemberTable extends StatelessWidget {
  const MemberTable({
    super.key,
    required this.data,
  });
  final DetailGroupModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).round()),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(
            Colors.grey.shade50,
          ),
          headingRowHeight: 56,
          columnSpacing: 20,
          horizontalMargin: 20,
          dividerThickness: 0.5,
          columns: [
            DataColumn(
              label: Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            DataColumn(
              label: Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Role',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
          rows: data.members.map(
            (v) {
              final isLeader = v.id == data.leader.id;
              return DataRow(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.blue.withAlpha((0.04 * 255).round());
                    }
                    return null;
                  },
                ),
                cells: [
                  DataCell(
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: isLeader
                              ? Colors.amber.shade100
                              : Colors.blue.shade100,
                          child: Text(
                            v.userName.isNotEmpty
                                ? v.userName[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isLeader
                                  ? Colors.amber.shade800
                                  : Colors.blue.shade800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            v.userName,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Text(
                      v.email,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isLeader
                            ? Colors.amber.shade50
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isLeader
                              ? Colors.amber.shade200
                              : Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isLeader ? Icons.star : Icons.person,
                            size: 14,
                            color: isLeader
                                ? Colors.amber.shade700
                                : Colors.blue.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isLeader ? 'Leader' : 'Member',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isLeader
                                  ? Colors.amber.shade700
                                  : Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
