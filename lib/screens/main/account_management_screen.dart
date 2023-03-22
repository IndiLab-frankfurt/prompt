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
        child: Column(children: [
          UIHelper.verticalSpaceMedium,
          Text(
            vm.username,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          buildDeleteAccountButton(context, vm),
        ]),
      ),
    );
  }

  Widget buildDeleteAccountButton(
      BuildContext context, AccountManagementViewModel vm) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => showDeleteAccountDialog(context, vm),
        child: Text('Press here to delete your account'),
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
            title: Text('Delete Account?'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Please enter your password to confirm:'),
                TextField(
                  obscureText: true,
                  onChanged: (value) => password = value,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
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
                child: Text('Confirm'),
              ),
            ],
          );
        });
  }
}
