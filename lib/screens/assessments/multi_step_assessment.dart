import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/multi_step_assessment_view_model.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/widgets/full_width_button.dart';

class MultiStepAssessment extends StatefulWidget {
  final MultiStepAssessmentViewModel vm;
  final List<Widget> pages;
  final int initialStep;
  // final VoidCallback onSubmit;
  MultiStepAssessment(this.vm, this.pages, {this.initialStep = 0, Key? key})
      : super(key: key);

  @override
  _MultiStepAssessmentState createState() => _MultiStepAssessmentState();
}

class _MultiStepAssessmentState extends State<MultiStepAssessment> {
  var _controller = new PageController();
  final _kDuration = const Duration(milliseconds: 100);
  final _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();

    _controller = new PageController(initialPage: widget.vm.step);
    _controller.addListener(() {
      int step = 0;
      if (_controller.page != null) {
        step = _controller.page!.round();
      }
      widget.vm.step = step;
      widget.vm.onPageChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildPageView());
  }

  _buildPageView() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          UIHelper.verticalSpaceMedium(),
          Flexible(
            child: PageView.builder(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.pages.length,
              itemBuilder: (context, index) {
                return widget.pages[index];
              },
            ),
          ),
          if (widget.vm.step < widget.pages.length - 1)
            _buildBottomNavigation(),
          if (widget.vm.step == widget.pages.length - 1) _buildSubmitButton()
        ],
      ),
    );
  }

  _buildSubmitButton() {
    return FullWidthButton(
      onPressed: () async {
        widget.vm.submit();
      },
      text: "Weiter",
    );
  }

  _buildBottomNavigation() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: widget.vm.canMoveBack(
                _keyOfCurrent()), // _index > 1 && _index < _pages.length - 1,
            child: TextButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.navigate_before),
                  Text(
                    "Zurück",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              onPressed: () {
                _controller.previousPage(duration: _kDuration, curve: _kCurve);
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: widget.vm.canMoveNext(_keyOfCurrent()),
            child: ElevatedButton(
              child: Row(
                children: <Widget>[
                  Text(
                    widget.vm.nextButtonText,
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.navigate_next)
                ],
              ),
              onPressed: () {
                if (widget.vm.canMoveNext(_keyOfCurrent())) {
                  _controller
                      .jumpToPage(widget.vm.getNextPage(_keyOfCurrent()));
                  widget.vm.clearCurrent();
                }
                setState(() {});
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }

  _keyOfCurrent() {
    if (widget.pages.length > 0) {
      return widget.pages[_controller.currentPageOrZero].key;
    }
    return ValueKey("");
  }
}
