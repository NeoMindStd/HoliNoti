import 'package:flutter/material.dart';
import 'package:holinoti_admin/constants/enums.dart' as Enums;
import 'package:holinoti_admin/data/relation_af.dart';
import 'package:holinoti_admin/utils/data_manager.dart';
import 'package:holinoti_admin/utils/dialog.dart';

class FavoriteButton extends StatelessWidget {
  final int fCode;
  final BuildContext _context;

  static const Map<Enums.Role, IconData> iconMap = {
    null: Icons.favorite_border,
    Enums.Role.customer: Icons.favorite,
    Enums.Role.manager: Icons.work,
    Enums.Role.supervisor: Icons.supervisor_account,
  };
  static const Map<Enums.Role, Color> colorMap = {
    null: Colors.black,
    Enums.Role.customer: Colors.red,
    Enums.Role.manager: Colors.brown,
    Enums.Role.supervisor: Colors.green,
  };

  FavoriteButton(this.fCode, this._context);

  void onPressed(RelationAF relationAF) {
    if (relationAF == null || relationAF.role == null)
      DataManager().dataBloc.addRelationAF(RelationAF(
            userId: DataManager().currentUser.id,
            facilityCode: fCode,
            role: Enums.Role.customer,
          ));
    else if (relationAF.role == Enums.Role.customer) {
      DataManager().dataBloc.deleteRelationAF(relationAF);
    } else {
      AppDialog(_context).showYesNoDialog(
        "정말 관리자를 그만두시겠습니까?",
        onConfirm: () => DataManager().dataBloc.deleteRelationAF(relationAF),
      );
    }
  }

  Widget build(BuildContext context) => StreamBuilder<List<RelationAF>>(
        initialData: DataManager().relationAFs,
        stream: DataManager().dataBloc.relationAFsStream,
        builder: (context, snapshot) {
          assert(snapshot != null || snapshot.data != null);
          int index = snapshot.data.indexWhere(
              (RelationAF relationAF) => relationAF.facilityCode == fCode);
          RelationAF relationAF = index > -1 ? snapshot.data[index] : null;
          Enums.Role role = relationAF == null ? null : relationAF.role;
          return IconButton(
            icon: Icon(
              iconMap[role],
              color: colorMap[role],
            ),
            onPressed: () => onPressed(relationAF),
          );
        },
      );
}
