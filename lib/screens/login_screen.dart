import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;

  LoginScreen({
    Key? k,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.highlightColor,
    required this.foregroundColor,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userIdTextController = TextEditingController();
  late TextEditingController _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((val) {
      _userIdTextController.text =
          Provider.of<LoginViewModel>(context, listen: false).email;
    });
  }

  _buildErrorDialog(String title, String content) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text("Okay"),
                onPressed: () async {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  _signInClick(LoginViewModel vm, BuildContext context) async {
    var registered = await vm.signIn(
        _userIdTextController.text, _passwordTextController.text);
    if (registered == RegistrationCodes.SUCCESS) {
      vm.submit();
    } else if (registered == RegistrationCodes.USER_NOT_FOUND) {
      _buildErrorDialog("Falscher Code",
          "Der eingegebene Code war nicht richtig. Bitte überprüfe, ob du ihn richtig eingegeben hast.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildControls(context),
    );
  }

  buildCircleAvatar() {
    return Container(
      height: 128.0,
      width: 128.0,
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        foregroundColor: this.widget.foregroundColor,
        radius: 100.0,
        backgroundImage: AssetImage('assets/icons/icon_256.png'),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //image: DecorationImage(image: this.logo)
      ),
    );
  }

  buildUserIdField(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: this.widget.foregroundColor,
              width: 0.5,
              style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: TextFormField(
              controller: _userIdTextController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (text) {
                // Provider.of<LoginState>(context).userId =
              },
              validator: (String? arg) {
                if (arg!.length != 6) {
                  return "Dein Code sollte aus sechs Zeichen bestehen";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                // labelText: "Email",
                // alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: AppStrings.LoginScreen_EnterCode,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildSubmitButton(BuildContext context) {
    var vm = Provider.of<LoginViewModel>(context);
    return new ElevatedButton(
      onPressed: () async {
        if (vm.state != ViewState.idle) return;
        if (_userIdTextController.text.length != 6) {
          _buildErrorDialog("Der Code besteht aus 6 Ziffern", "");
        } else {
          await _signInClick(vm, context);
        }
      },
      child: vm.state == ViewState.idle
          ? Text("Anmelden")
          : CircularProgressIndicator(),
    );
  }

  Widget buildControls(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                1.0, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              this.widget.backgroundColor1,
              this.widget.backgroundColor2
            ], // whitish to gray
            // tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            buildUserIdField(context),
            // buildPasswordInput(context),
            new Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
              alignment: Alignment.center,
              child: new Row(
                children: <Widget>[
                  new Expanded(child: buildSubmitButton(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
