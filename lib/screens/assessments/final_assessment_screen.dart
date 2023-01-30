import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:prompt/screens/assessments/final_plan_display.dart';
import 'package:prompt/screens/assessments/multi_page_screen.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/final_asssessment_view_model.dart';
import 'package:provider/provider.dart';

class FinalAssessmentScreen extends StatefulWidget {
  const FinalAssessmentScreen({Key? key}) : super(key: key);

  @override
  _FinalAssessmentScreenState createState() => _FinalAssessmentScreenState();
}

class _FinalAssessmentScreenState extends State<FinalAssessmentScreen> {
  List<Widget> _pages = [];

  late FinalAssessmentViewModel vm =
      Provider.of<FinalAssessmentViewModel>(context);

  late Map<FinalAssessmentStep, Widget> _stepScreenMap = {
    FinalAssessmentStep.introduction: introduction,
    FinalAssessmentStep.planDisplay: planDisplay,
    FinalAssessmentStep.completed: completed
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _pages = [];

    for (var page in vm.screenOrder) {
      if (_stepScreenMap.containsKey(page)) {
        _pages.add(_stepScreenMap[page]!);
      } else {
        throw Exception("The requested screen is not mapped");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Container(
                margin: UIHelper.containerMargin,
                child: MultiPageScreen(
                  vm,
                  _pages,
                ))));
  }

  late var introduction = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(
        data: "### " +
            "Heute ist der letzte Tag, an dem du PROMPT jeden Tag benutzen solltest."),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Wir haben jetzt noch ein paar Fragen dazu, wie die Studie bisher für dich gewesen ist."),
  ]);

  late var planDisplay = FutureBuilder(
      future: vm.getPlan(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            var plan = snapshot.data as String;
            return FinalPlanDisplay(plan: plan);
          }
        }
        return Container(child: CircularProgressIndicator());
      });

  late var completed = ListView(children: [
    UIHelper.verticalSpaceLarge(),
    MarkdownBody(data: "### " + "Danke!"),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "Die letzten beiden Vokabellisten sollst du nun alleine lernen. Ab morgen musst du also nicht mehr täglich PROMPT benutzen. Nur an den Tagen, an denen du den Vokabeltest machst, sollst du noch einmal Fragen beantworten."),
    UIHelper.verticalSpaceMedium(),
    MarkdownBody(
        data: "### " +
            "**Wichtig:** Behalte die App PROMPT auf dem Handy. An den Tagen, an denen du den Vokabeltest machen sollst, schicken wir dir eine Notification."),
  ]);
}
