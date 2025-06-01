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
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'User Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Role',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: data.members.map(
        (v) {
          return DataRow(
            cells: [
              DataCell(Text(v.userName)),
              DataCell(Text(v.email)),
              DataCell(
                Text(
                  v.id == data.leader.id ? 'Leader' : 'Member',
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
