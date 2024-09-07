import 'package:flutter/material.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/core/auth/presentation/login_page.dart';
import 'package:lpu_events/core/home/presentation/admin/presentation/admin_page.dart';
import 'package:lpu_events/core/home/presentation/events/presentation/event_page.dart';
import 'package:lpu_events/core/home/presentation/groups/groups_page.dart';
import 'package:lpu_events/core/home/presentation/search/presentation/search_page.dart';
import 'package:lpu_events/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(appCache.getUserName()),
              accountEmail: Text(appState.value.user!.registrationNo),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () => {
                goToPage(context, const LoginPage(), clearStack: true),
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LPU Events"),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
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
                appCache.isManager() ? const AdminPage() : const EventPage(),
                const SearchPage(),
                const GroupsPage()
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
