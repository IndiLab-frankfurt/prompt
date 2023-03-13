import 'package:flutter/material.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/multi_page_view_model.dart';
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
      setState(() {
        FocusManager.instance.primaryFocus?.unfocus();
      });
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onHorizontalDragEnd: (details) async {
          if (!widget.useGestures) return;
          if (details.primaryVelocity == null) return;

          int sensitivity = 30;

          // Swiping in right direction.
          if (details.primaryVelocity! > sensitivity) {
            if (widget.vm.canMoveBack()) {
              await widget.vm.previousPage();
            }
          }
          // Swiping in left direction.
          if (details.primaryVelocity! < sensitivity) {
            if (widget.vm.canMoveNext()) {
              await widget.vm.nextPage();
            }
          }
        },
        child: _buildPageView());
  }

  _buildPageView() {
    if (widget.vm.state == ViewState.busy) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 40),
            child: PageView.builder(
              controller: _controller,
              // We need increased control, so we cannot use the default of the pageview here
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.pages.length,
              itemBuilder: (context, index) {
                return KeepAlivePage(child: widget.pages[index]);
              },
            ),
          ),
          if (widget.showBottomBar) _buildBackButton(),
          if (widget.showBottomBar) _buildNextButton(),
        ],
      ),
    );
  }

  _buildBackButton() {
    return Positioned(
      bottom: 5,
      left: 5,
      child: Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: widget.vm.canMoveBack() && widget.vm.page > 0,
        child: SizedBox(
          height: 40,
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
    );
  }

  _buildNextButton() {
    if (widget.vm.state == ViewState.busy) {
      return Center(child: CircularProgressIndicator());
    }

    return Positioned(
      bottom: 5,
      right: 5,
      child: Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: widget.vm.canMoveNext(),
        child: SizedBox(
          height: 40,
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
    );
  }
}
