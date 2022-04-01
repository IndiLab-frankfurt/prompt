import 'package:flutter/material.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/registration_view_model.dart';
import 'package:provider/provider.dart';
import 'package:prompt/shared/enums.dart';

class RegistrationScreen extends StatefulWidget {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color highlightColor;
  final Color foregroundColor;

  RegistrationScreen({
    Key? k,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.highlightColor,
    required this.foregroundColor,
  });

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _userIdTextController = TextEditingController();
  late TextEditingController _passwordTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((val) {
      _userIdTextController.text =
          Provider.of<RegistrationViewModel>(context, listen: false).email;
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

  _registerClick(RegistrationViewModel vm, BuildContext context) async {
    if (!vm.validatePassword(_passwordTextController.text)) {
      _buildErrorDialog("Ungültiges Passwort",
          "Das Passwort muss mindestens 6 Zeichen lang sein.");
      return;
    }

    if (!vm.validateEmail(_userIdTextController.text)) {
      _buildErrorDialog("Ungültige Email Adresse",
          "Bitte gib eine gültige Email Adresse ein.");
      return;
    }

    var registered = await vm.register(
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
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            buildEmailField(context),
            buildPasswordField(context),
            UIHelper.verticalSpaceMedium(),
            buildSwitchToLogin(),
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

  buildEmailField(BuildContext context) {
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (text) {
                // Provider.of<LoginState>(context).userId =
              },
              validator: (String? arg) {
                if (arg!.length != 6) {
                  return "Der Code sollte aus sechs Zeichen bestehen";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Email",
                alignLabelWithHint: true,
                border: InputBorder.none,
                // hintText: "Email Adresse eingeben",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildPasswordField(BuildContext context) {
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
              autocorrect: false,
              obscureText: true,
              enableSuggestions: false,
              controller: _passwordTextController,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              onChanged: (text) {
                // Provider.of<LoginState>(context).userId =
              },
              validator: (String? arg) {
                if (arg!.length < 6) {
                  return "Das Passwort sollte mindestens 6 Zeichen lang sein";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Passwort",
                alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: "Mindestens 6 Zeichen",
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildSwitchToLogin() {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
      alignment: Alignment.center,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.LOG_IN);
              },
              child: new Text(
                "Du hast bereits einen Account? Hier klicken zum einzuloggen.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildSubmitButton(BuildContext context) {
    var vm = Provider.of<RegistrationViewModel>(context);
    return new ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size(200, 50)),
      onPressed: () async {
        if (vm.state != ViewState.idle) return;
        if (!await vm.isEmailAlreadyRegistered(_userIdTextController.text)) {
          _buildErrorDialog("Email bereits registriert",
              "Die Email Adresse ist bereits registriert. Bitte logge dich mit deinem Passwort ein.");
        } else {
          _registerClick(vm, context);
        }
      },
      child: vm.state == ViewState.idle
          ? Text("Registrieren")
          : CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
    );
  }
}
