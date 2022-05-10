import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/models/learning_tip.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/learning_tip_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:provider/provider.dart';

class SingleLearningTipScreen extends StatefulWidget {
  const SingleLearningTipScreen({Key? key}) : super(key: key);

  @override
  State<SingleLearningTipScreen> createState() =>
      _SingleLearningTipScreenState();
}

class _SingleLearningTipScreenState extends State<SingleLearningTipScreen> {
  late var vm = Provider.of<LearningTipViewModel>(context);
  late Future<LearningTip> _learningTipFuture = vm.getLearningTip();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: UIHelper.baseGradient,
            image: DecorationImage(
                image:
                    AssetImage("assets/illustrations/mascot_1_lightbulb.png"),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter)),
        child: FutureBuilder(
            future: _learningTipFuture,
            builder:
                (BuildContext context, AsyncSnapshot<LearningTip> snapshot) {
              if (snapshot.hasData) {
                return Container(
                    margin: UIHelper.containerMargin,
                    // add a white background with a bit of transparency
                    // color: Colors.white.withOpacity(0.7),
                    child: buildTipScreen(context));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  buildTipScreen(BuildContext context) {
    var vm = Provider.of<LearningTipViewModel>(context);

    var tip = vm.learningTip!;
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Text(tip.title,
                  style: Theme.of(context).textTheme.headlineMedium),
              UIHelper.verticalSpaceMedium(),
              Container(
                  // color: Colors.white.withOpacity(0.7),
                  padding: EdgeInsets.all(10),
                  // add rounded corners
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.7)),
                  child: MarkdownBody(data: tip.learningTip)),
              // Container(
              //     padding: EdgeInsets.all(10),
              //     child: MarkdownBody(data: tip.learningTip)),
              // Container(
              //     padding: EdgeInsets.all(10),
              //     child: MarkdownBody(data: tip.learningTip)),
            ],
          ),
        ),
        // Spacer(),
        // _buildSubmitButton(context),
      ],
    );
  }
}

_buildSubmitButton(BuildContext context) {
  var vm = Provider.of<LearningTipViewModel>(context);
  if (vm.state == ViewState.idle) {
    return FullWidthButton(
      onPressed: () async {
        vm.submit();
      },
      text: "Weiter",
    );
  }

  return Container();
}
