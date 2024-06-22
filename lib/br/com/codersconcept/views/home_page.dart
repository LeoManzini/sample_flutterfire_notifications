import 'package:flutter/material.dart';
import 'package:sample_flutterfire_notifications/br/com/codersconcept/controllers/auth_service.dart';
import 'package:sample_flutterfire_notifications/br/com/codersconcept/controllers/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    NotificationService.getDeviceToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.logout();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
