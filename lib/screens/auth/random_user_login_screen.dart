import 'package:flutter/material.dart';
import 'package:prompt/viewmodels/random_user_login_view_model.dart';
import 'package:provider/provider.dart';

class RandomUserLoginScreen extends StatefulWidget {
  const RandomUserLoginScreen({Key? key}) : super(key: key);

  @override
  State<RandomUserLoginScreen> createState() => _RandomUserLoginScreenState();
}

class _RandomUserLoginScreenState extends State<RandomUserLoginScreen> {
  late Future<bool> _future = vm.loginAsRandomUser();
  late RandomUserLoginViewModel vm;
  @override
  void initState() {
    super.initState();
    // _future = vm.loginAsRandomUser();
  }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<RandomUserLoginViewModel>(context);
    // vm.loginAsRandomUser();

    return Scaffold(
      body: Container(
          child: Container(
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              return Center(
                  child: Column(children: [
                CircularProgressIndicator(),
                Text("Sie werden eingelogt..."),
              ]));
            }),
      )),
    );
  }
}
