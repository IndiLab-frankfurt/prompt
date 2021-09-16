import 'package:flutter/material.dart';
import 'package:prompt/shared/app_strings.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class CabuuLinkScreen extends StatelessWidget {
  const CabuuLinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                  tristate: false,
                  onChanged: (value) {
                    vm.consented = value!;
                  },
                  value: vm.consented),
              Flexible(
                child: Text(
                  AppStrings.CabuuLink_WantToParticipate,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpaceLarge(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              AppStrings.CabuuLink_EnterEmail,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          buildEmailField(context),
          UIHelper.verticalSpaceLarge(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              AppStrings.CabuuLink_EnterUsername,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          buildUserIdField(context),
        ],
      ),
    );
  }

  buildUserIdField(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
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
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              onChanged: (text) {
                // Provider.of<LoginState>(context).userId =
                vm.cabuuLinkUserName = text;
              },
              validator: (String? arg) {
                return null;
              },
              decoration: InputDecoration(
                // labelText: "Email",
                // alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: 'Nutzername',
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildEmailField(BuildContext context) {
    var vm = Provider.of<SessionZeroViewModel>(context);
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (text) {
                vm.cabuuLinkEmail = text;
              },
              validator: (String? arg) {
                return null;
              },
              decoration: InputDecoration(
                // labelText: "Email",
                // alignLabelWithHint: true,
                border: InputBorder.none,
                hintText: 'E-Mail',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
