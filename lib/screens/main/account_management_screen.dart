import 'package:flutter/material.dart';
import 'package:prompt/l10n/localization/generated/l10n.dart';
import 'package:prompt/shared/ui_helper.dart';
import 'package:prompt/viewmodels/account_management_view_model.dart';
import 'package:prompt/widgets/prompt_appbar.dart';
import 'package:prompt/widgets/prompt_drawer.dart';
import 'package:provider/provider.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<AccountManagementViewModel>(context);
    return Scaffold(
      appBar: PromptAppBar(showBackButton: true),
      drawer: PromptDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(children: [
            UIHelper.verticalSpaceMedium,
            Text(
              S.of(context).accountManagement_yourAccountName(vm.username),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            UIHelper.verticalSpaceMedium,
            buildLogoutButton(context, vm),
            UIHelper.verticalSpaceMedium,
            Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(255, 223, 152, 152),
                child: Column(
                  children: [
                    Text(
                      S.of(context).accountManagement_deleteAccountExplanation,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    UIHelper.verticalSpaceMedium,
                    buildDeleteAccountButton(context, vm),
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  Widget buildLogoutButton(
      BuildContext context, AccountManagementViewModel vm) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.primary),
        ),
        onPressed: () => showDeleteAccountDialog(context, vm),
        child: Text(
          S.of(context).general_buttonTexts_logout,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildDeleteAccountButton(
      BuildContext context, AccountManagementViewModel vm) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.error),
        ),
        onPressed: () => showDeleteAccountDialog(context, vm),
        child: Text(
          S.of(context).accountManagement_clickToDeleteAccount,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> showDeleteAccountDialog(
      BuildContext context, AccountManagementViewModel vm) async {
    String? password;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.of(context).accountManagement_deleteDialog_title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    S.of(context).accountManagement_deleteDialog_EnterPassword),
                TextField(
                  obscureText: true,
                  onChanged: (value) => password = value,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.of(context).general_buttonTexts_cancel),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (password == null) {
                    return;
                  }
                  bool success = await vm.deleteAccount(password!);
                  if (success) {
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text(S.of(context).accountManagement_invalidPassword),
                      duration: Duration(seconds: 3),
                    ));
                  }
                },
                child: Text(S.of(context).general_buttonTexts_confirm),
              ),
            ],
          );
        });
  }
}
