import 'package:flutter/material.dart';

showAbout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("About Zonnebloem-software"),
        content: const Text("KVK"),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
