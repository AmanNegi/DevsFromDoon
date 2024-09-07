import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/core/home/presentation/event_item.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_manager.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_repository.dart';
import 'package:lpu_events/core/home/presentation/events/presentation/event_detail_page.dart';
import 'package:lpu_events/core/home/presentation/groups/chat_page.dart';
import 'package:lpu_events/globals.dart';

class GroupsPage extends ConsumerStatefulWidget {
  const GroupsPage({super.key});

  @override
  ConsumerState<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends ConsumerState<GroupsPage> {
  late EventsManager eventsManager;

  @override
  void initState() {
    eventsManager = EventsManager(context, ref);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        appState.value.user!.role == "manager"
            ? eventsManager.getAllEventsOfManager()
            : eventsManager.getAllRegisteredEvents(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (ref.watch(eventRepository).myEvents.isEmpty)
            const Expanded(
              child: Center(
                child: Text("No Items to show"),
              ),
            ),
          ...ref.watch(eventRepository).myEvents.map((e) {
            return ListTile(
              trailing: CircleAvatar(
                radius: 15.0,
                child: Text(Random().nextInt(4).toString()),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(e.imageUrl),
                radius: 25.0,
              ),
              onTap: () {
                goToPage(context, const ChatPage());
              },
              title: Text(e.title),
              subtitle: Text(e.description),
            );
          }).toList(),
        ],
      ),
    );
  }
}
