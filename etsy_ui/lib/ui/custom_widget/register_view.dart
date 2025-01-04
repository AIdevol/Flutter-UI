import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheetExample();
  }
}

class CupertinoActionSheetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Action Sheet"),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text("Show Action Sheet"),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  title: Text("Actions"),
                  message: Text("Choose an option below"),
                  actions: <CupertinoActionSheetAction>[
                    CupertinoActionSheetAction(
                      child: Text("Option 1"),
                      onPressed: () {
                        Navigator.pop(context);
                        print("Option 1 selected");
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: Text("Option 2"),
                      onPressed: () {
                        Navigator.pop(context);
                        print("Option 2 selected");
                      },
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    isDefaultAction: true,
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
