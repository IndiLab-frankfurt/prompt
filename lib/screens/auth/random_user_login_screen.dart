import 'package:flutter/material.dart';
import 'package:prompt/viewmodels/random_user_login_view_model.dart';
import 'package:provider/provider.dart';

class RandomUserLoginScreen extends StatelessWidget {
  const RandomUserLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<RandomUserLoginViewModel>(context);
    vm.loginAsRandomUser();

    return Scaffold(
      body: Container(
          child: Center(
        child: Text("Sie werden eingelogt..."),
      )),
    );
  }
}
