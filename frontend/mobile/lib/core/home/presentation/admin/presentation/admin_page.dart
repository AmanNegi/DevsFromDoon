import 'package:flutter/material.dart';
import 'package:lpu_events/core/home/presentation/admin/presentation/add_event_page.dart';
import 'package:lpu_events/globals.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getHeading("Your Events"),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: kToolbarHeight + 10,
          child: FloatingActionButton.extended(
            elevation: 1,
            onPressed: () {
              goToPage(context, const AddItemPage());
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Event"),
          ),
        ),
      ]),
    );
  }

  getHeading(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
