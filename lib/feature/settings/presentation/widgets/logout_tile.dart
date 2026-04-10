import 'package:flutter/material.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout, color: Colors.red),
      title: const Text("Logout"),
      onTap: () {
        // TODO: logout logic
      },
    );
  }
}