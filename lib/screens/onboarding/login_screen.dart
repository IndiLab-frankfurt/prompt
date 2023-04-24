import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? k,
  });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userIdTextController = TextEditingController();
  late TextEditingController _passwordTextController = TextEditingController();
  bool _obscurePassword = true;
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
    var registrationResponse = await vm.signIn(
        _userIdTextController.text, _passwordTextController.text);
    if (registrationResponse == RegistrationCodes.USER_NOT_FOUND) {
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

  Widget buildControls(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              UIHelper.verticalSpaceLarge,
              buildCircleAvatar(),
              UIHelper.verticalSpaceLarge,
              buildTitle(),
              UIHelper.verticalSpaceLarge,
              buildUserIdField(context),
              buildPasswordField(context),
              new Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
                alignment: Alignment.center,
                child: new Row(
                  children: <Widget>[
                    new Expanded(child: buildSubmitButton(context)),
                  ],
                ),
              ),
              UIHelper.verticalSpaceLarge,
              UIHelper.verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }

  buildCircleAvatar() {
    return Container(
      height: 128.0,
      width: 128.0,
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        backgroundImage: AssetImage('assets/icons/icon_256.png'),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        //image: DecorationImage(image: this.logo)
      ),
    );
  }

  buildTitle() {
    return Container(
        height: 128.0, width: 128.0, child: Text("PROMPT ICAB-LAB"));
  }

  buildUserIdField(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.black, width: 0.5, style: BorderStyle.solid),
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
              onChanged: (text) {},
              validator: (String? arg) {
                if (arg!.length != 6) {
                  return S.of(context).login_codeLengthErrorText;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).login_enterCode,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildPasswordField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Colors.black, width: 0.5, style: BorderStyle.solid),
        ),
      ),
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              obscureText: _obscurePassword,
              controller: _passwordTextController,
              textAlign: TextAlign.center,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bitte gib dein Passwort ein';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: S.of(context).login_passwordHintText,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
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
      style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
      onPressed: () async {
        if (vm.state != ViewState.Idle) return;
        if (_userIdTextController.text.length != 6) {
          _buildErrorDialog(S.of(context).login_codeLengthErrorText, "");
        } else {
          await _signInClick(vm, context);
        }
      },
      child: vm.state == ViewState.Idle
          ? Text(S.of(context).login_loginButton)
          : CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
    );
  }
}
