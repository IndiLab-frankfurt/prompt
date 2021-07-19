import 'package:flutter/material.dart';
import 'package:prompt/shared/enums.dart';

class BaseViewModel extends ChangeNotifier {
  final GlobalKey<State> keyLoader = new GlobalKey<State>();
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
