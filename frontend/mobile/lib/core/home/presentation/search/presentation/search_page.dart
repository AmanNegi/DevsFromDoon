import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/core/home/presentation/event_item.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_manager.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';
import 'package:lpu_events/widgets/custom_text_field.dart';
import "package:http/http.dart" as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  SearchManager manager = SearchManager();
  List<Event> results = [];
  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getSearchField(),
          SizedBox(height: 0.025 * getHeight(context)),
          ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, child) {
                if (value) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (query.isEmpty || query.length < 3) {
                  return const Expanded(
                    child: Center(
                        child: Text("Query should be atleast 3 letters long")),
                  );
                }

                if (results.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text("No Items Found")),
                  );
                }

                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    children: results.map((e) => EventItem(event: e)).toList(),
                  ),
                );
              }),
        ],
      ),
    );
  }

  Container _getSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              hint: "Enter your query here",
              onSubmitted: (v) {
                performSearch();
              },
              onChanged: (v) {
                query = v;
              },
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
                color: accentColor, borderRadius: BorderRadius.circular(10.0)),
            child: IconButton(
              onPressed: () async {
                await performSearch();
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  performSearch() async {
    print("Searching $query...");
    loading.value = true;
    results = await manager.search(query);
    loading.value = false;
    setState(() {});
  }
}

class SearchManager {
  Future<List<Event>> search(String query) async {
    final res = await http.get(Uri.parse("$API_URL/events/all"));

    print(res.body);
    final mappedBody = json.decode(res.body);
    List<Event> events = (mappedBody["events"] as List<dynamic>)
        .map((e) => Event.fromMap(e))
        .toList();

    return events
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
