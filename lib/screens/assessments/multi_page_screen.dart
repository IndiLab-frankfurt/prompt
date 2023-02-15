import 'package:flutter/material.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
import 'package:prompt/shared/extensions.dart';
import 'package:prompt/widgets/full_width_button.dart';

class MultiPageScreen extends StatefulWidget {
  final MultiPageViewModel vm;
  final List<Widget> pages;
  final int initialStep;
  MultiPageScreen(this.vm, this.pages, {this.initialStep = 0, Key? key})
      : super(key: key);

  @override
  _MultiPageScreenState createState() => _MultiPageScreenState();
}

class _MultiPageScreenState extends State<MultiPageScreen> {
  var _controller = new PageController();
  final _kDuration = const Duration(milliseconds: 100);
  final _kCurve = Curves.ease;

  @override
  void initState() {
    super.initState();

    _controller = new PageController();
    // _controller.addListener(() {
    //   int page = 0;
    //   if (_controller.page != null) {
    //     page = _controller.page!.round();
    //   }
    //   widget.vm.page = page;
    //   widget.vm.onPageChange();
    // });

    widget.vm.currentPageStream.listen((index) {
      _controller.animateToPage(index, duration: _kDuration, curve: _kCurve);
      setState(() {});
    });

    Future.delayed(Duration(milliseconds: 1), (() {
      print("Jumping to page ${widget.vm.initialPage}");
      _controller.jumpToPage(widget.vm.initialPage);
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageView();
  }

  _buildPageView() {
    return Container(
      child: Column(
        children: [
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
          _buildBottomNavigation(),
          if (widget.vm.page < widget.pages.length - 1)
            if (widget.vm.page == widget.pages.length - 1) _buildSubmitButton()
        ],
      ),
    );
  }

  _buildSubmitButton() {
    if (widget.vm.canMoveNext(_keyOfCurrent())) {
      if (widget.vm.state == ViewState.idle) {
        return FullWidthButton(
          key: ValueKey("submitButton"),
          onPressed: () async {
            widget.vm.submit();
          },
          text: "Weiter",
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    }
    return Container();
  }

  _buildBottomNavigation() {
    if (widget.vm.state == ViewState.busy) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible:
                widget.vm.canMoveBack(_keyOfCurrent()) && widget.vm.page > 0,
            child: SizedBox(
              height: 50,
              child: TextButton(
                key: ValueKey("backButton"),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.navigate_before),
                    Text(
                      "Zurück",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                onPressed: () async {
                  await widget.vm.previousPage();
                },
              ),
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: widget.vm.canMoveNext(_keyOfCurrent()),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                key: ValueKey("nextButton"),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Weiter",
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.navigate_next)
                  ],
                ),
                onPressed: () async {
                  await widget.vm.nextPage();
                },
              ),
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
