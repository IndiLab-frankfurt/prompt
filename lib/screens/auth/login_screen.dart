import 'package:flutter/material.dart';
import 'package:prompt/shared/route_names.dart';
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
    vm
        .signIn(_userIdTextController.text, _passwordTextController.text)
        .then((value) {
      if (value == RegistrationCodes.SUCCESS) {
        vm.submit();
      } else {
        _buildErrorDialog("Ungültige Anmeldedaten",
            "Die eingegebene Email Adresse oder das Passwort waren nicht richtig.");
      }
    }).catchError((error) {
      _buildErrorDialog("Ungültige Anmeldedaten",
          "Die eingegebene Email Adresse oder das Passwort waren nicht richtig.");
    });
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
                return null;
              },
              decoration: InputDecoration(
                labelText: "Email",
                alignLabelWithHint: true,
                border: InputBorder.none,
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
        if (vm.state != ViewState.idle) return;
        if (_userIdTextController.text.length == 0) {
          _buildErrorDialog("Es wurde keine Email Adresse eingegeben", "");
          return;
        }
        if (_passwordTextController.text.length == 0) {
          _buildErrorDialog("Es wurde kein Passwort eingegeben", "");
          return;
        }
        await _signInClick(vm, context);
      },
      child: vm.state == ViewState.idle
          ? Text("Anmelden")
          : CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
    );
  }

  buildSwitchToRegister() {
    return new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
      alignment: Alignment.center,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.REGISTER);
              },
              child: new Text(
                "Sie haben noch keinen Account? Hier klicken um sich zu registrieren.",
                textAlign: TextAlign.center,
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
              onChanged: (text) {},
              validator: (String? arg) {
                if (arg!.length < 6) {
                  return "Das Passwort sollte mindestens 6 Zeichen lang sein";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Password",
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
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
            buildPasswordField(context),
            UIHelper.verticalSpaceLarge(),
            buildSwitchToRegister(),
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
