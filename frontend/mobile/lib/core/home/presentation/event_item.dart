import 'package:flutter/material.dart';
import 'package:lpu_events/core/home/presentation/events/presentation/event_detail_page.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        goToPage(context, EventDetailPage(event: event));
      },
      child: SizedBox(
        width: 0.6 * getWidth(context),
        height: 0.2 * getHeight(context),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                child: Text(event.isLeaveProvided ? "DL" : "No DL"),
              ),
            ),
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 10.0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          event.imageUrl,
                          height: 0.135 * getHeight(context),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0),
                      child: Row(
                        children: [
                          Text(
                            event.name,
                            style: const TextStyle(),
                          ),
                          const Spacer(),
                          // Text(event.price)
                          Text(event.price.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
