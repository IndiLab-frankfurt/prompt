import 'dart:async';
import 'package:prompt/viewmodels/base_view_model.dart';

abstract class MultiPageViewModel extends BaseViewModel {
  List<dynamic> pages = [];

  final StreamController _currentPageController =
      StreamController<int>.broadcast();

  Sink get currentPage => _currentPageController.sink;

  Stream<int> get currentPageStream =>
      _currentPageController.stream.map((currentIndex) => currentIndex);

  // final StreamController _moveNextController =
  //     StreamController<int>.broadcast();

  // Sink get canMoveNext => _moveNextController.sink;

  // Stream<int> get canMoveNextStream =>
  //     _moveNextController.stream.map((value) => value);

  int page = 0;

  int initialPage = 0;

  Map<String, Map<String, dynamic>> timings = {};

  MultiPageViewModel();

  bool canMoveBack();

  bool canMoveNext();

  void submit();

  setPage(int page) {
    this.page = page;
    currentPage.add(page);
    notifyListeners();
  }

  Future<void> previousPage() async {
    if (canMoveBack()) {
      setPage(getPreviousPage());
    }
  }

  Future<void> nextPage() async {
    if (page == pages.length - 1) {
      submit();
    } else if (canMoveNext()) {
      setPage(getNextPage());
    }
  }

  int getNextPage() {
    if (page >= pages.length - 1) {
      return page;
    }
    return page + 1;
  }

  int getPreviousPage() {
    if (page <= 0) {
      return page;
    }
    return page - 1;
  }

  @override
  void dispose() {
    _currentPageController.close();
    super.dispose();
  }
}
