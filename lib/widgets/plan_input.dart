import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlanInput extends StatelessWidget {
  const PlanInput({
    Key? key,
    required this.plan,
    required this.onChanged,
  });

  final String plan;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).selectedRowColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            MarkdownBody(
                data: '### "${AppLocalizations.of(context)!.planInputIfI} '),
            UIHelper.horizontalSpaceSmall,
            Expanded(
              child: TextField(
                  controller: TextEditingController()..text = plan,
                  maxLines: 3,
                  minLines: 1,
                  onChanged: (newText) {
                    onChanged(newText);
                  },
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      fillColor: Theme.of(context).selectedRowColor,
                      filled: true,
                      hintText: '   ...'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            MarkdownBody(data: '### ,'),
          ],
        ),
        UIHelper.verticalSpaceSmall,
        MarkdownBody(
            data:
                '### ${AppLocalizations.of(context)!.planInputThenILearnWithCabuu} "'),
      ]),
    );
  }
}
