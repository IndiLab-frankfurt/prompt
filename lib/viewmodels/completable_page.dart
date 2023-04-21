import 'package:prompt/viewmodels/base_view_model.dart';

mixin CompletablePageMixin on BaseViewModel {
  bool completed = false;
  String name = "";
}
