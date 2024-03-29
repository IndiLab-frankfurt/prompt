import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/plan_input_view_model.dart';
import 'package:provider/provider.dart';

class PlanInput extends StatefulWidget {
  const PlanInput({
    Key? key,
    required this.vm,
    required this.onChanged,
  });

  final PlanInputViewModel vm;
  final Function? onChanged;

  @override
  State<PlanInput> createState() => _PlanInputState();
}

class _PlanInputState extends State<PlanInput> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.vm.input;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.vm,
        builder: (context, child) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  MarkdownBody(data: '### "${S.of(context).planInputIfI} '),
                  UIHelper.horizontalSpaceSmall,
                  Expanded(
                    child: TextField(
                        controller: _controller,
                        maxLines: 3,
                        minLines: 1,
                        onChanged: (newText) {
                          widget.vm.input = newText;
                          widget.onChanged?.call(newText);
                        },
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            fillColor: Colors.white70,
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
                  data: '### ${S.of(context).planInputThenILearnWithCabuu} "'),
            ]),
          );
        });
  }
}
