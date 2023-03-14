import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/viewmodels/plan_timing_view_model.dart';
import 'package:prompt/widgets/time_picker_grid_dialog.dart';
import 'package:provider/provider.dart';

class PlanTiming extends StatelessWidget {
  const PlanTiming({super.key});

  @override
  Widget build(BuildContext context) {
    return buildTimeSelector(context);
  }

  buildTimeSelector(BuildContext context) {
    var vm = Provider.of<PlanTimingViewModel>(context);
    return TextField(
      controller: TextEditingController(text: vm.timeDisplay),
      readOnly: true,
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return TimePickerGridDialog();
            }).then((value) {
          if (value == null) {
            return;
          }
          vm.savePlanTiming(value);
        });
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: S.of(context).time,
        suffixIcon: Icon(Icons.access_time),
        hintText: S.of(context).time,
      ),
    );
  }
}
