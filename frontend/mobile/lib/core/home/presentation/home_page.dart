import 'package:flutter/material.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/core/home/presentation/events/presentation/event_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LPU Events"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: TabBarView(
              controller: controller,
              children: [
                const EventPage(),
                Container(
                  color: Colors.yellow,
                ),
                Container(
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.025),
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                  )
                ],
              ),
              height: kToolbarHeight,
              child: Row(children: [
                getExpandedItem(0, "Events", Icons.event),
                getExpandedItem(1, "Search", Icons.search),
                getExpandedItem(2, "Groups", Icons.group),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget getExpandedItem(int index, String text, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
          controller.animateTo(index);
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: currentIndex == index ? Colors.black : Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: currentIndex == index ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
