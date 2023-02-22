import 'package:flutter/material.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
import 'package:prompt/widgets/full_width_button.dart';
import 'package:prompt/widgets/keep_alive_page.dart';

class MultiPageScreen extends StatefulWidget {
  final MultiPageViewModel vm;
  final List<Widget> pages;
  final int initialStep;
  final bool showBottomBar;
  final bool useGestures;
  MultiPageScreen(this.vm, this.pages,
      {this.initialStep = 0,
      this.showBottomBar = true,
      this.useGestures = false,
      Key? key})
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

    _controller = new PageController(keepPage: true);

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
    return GestureDetector(
      onHorizontalDragEnd: (details) async {
        if (details.primaryVelocity == null) return;

        int sensitivity = 6;

        // Swiping in right direction.
        if (details.primaryVelocity! > sensitivity) {
          await widget.vm.previousPage();
        }
        // Swiping in left direction.
        if (details.primaryVelocity! < sensitivity) {
          await widget.vm.nextPage();
        }
      },
      child: Container(
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                controller: _controller,
                // We need increased control, so we cannot use the default scroll physics here
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.pages.length,
                itemBuilder: (context, index) {
                  return KeepAlivePage(child: widget.pages[index]);
                },
              ),
            ),
            if (widget.showBottomBar) _buildBottomNavigation(),
            if (widget.vm.page < widget.pages.length - 1)
              if (widget.vm.page == widget.pages.length - 1)
                _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  _buildSubmitButton() {
    if (widget.vm.canMoveNext()) {
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
            visible: widget.vm.canMoveBack() && widget.vm.page > 0,
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
            visible: widget.vm.canMoveNext(),
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
}
