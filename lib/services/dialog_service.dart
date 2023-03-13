import 'dart:async';

import 'package:prompt/models/alert_request.dart';
import 'package:prompt/models/alert_response.dart';
import 'package:prompt/models/reward_request.dart';

// Taken from https://medium.com/flutter-community/manager-your-flutter-dialogs-with-a-dialog-manager-1e862529523a
class DialogService {
  Function(AlertRequest)? _showDialogListener;
  Function(RewardRequest)? _showRewardDialogListener;
  Completer<AlertResponse>? _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  void registerRewardDialogListener(
      Function(RewardRequest) showDialogListener) {
    _showRewardDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog(
      {required String title,
      required String description,
      String buttonTitle = "Ok"}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener?.call(AlertRequest(
        title: title, description: description, buttonTitle: buttonTitle));
    return _dialogCompleter!.future;
  }

  Future showRewardDialog({required String title, required int score}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showRewardDialogListener?.call(RewardRequest(score: score));
    return _dialogCompleter!.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter?.complete(response);
    _dialogCompleter = null;
  }
}
