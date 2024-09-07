import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/core/home/presentation/home_page.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';
import 'package:lpu_events/widgets/action_button.dart';
import 'package:lpu_events/widgets/custom_text_field.dart';
import "package:http/http.dart" as http;
import 'package:lpu_events/widgets/loading_widget.dart';

class FormPage extends StatefulWidget {
  final Event event;
  const FormPage({super.key, required this.event});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final formModel = {
    "fields": [
      {
        "title": "Name",
        "type": "text",
      },
      {
        "title": "Email",
        "type": "text",
      },
      {
        "title": "Contact Number",
        "type": "text",
      },
      {
        "title": "Registration Number",
        "type": "text",
      },
      {
        "title": "Department",
        "type": "text",
      },
      {
        "title": "Year",
        "type": "text",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    print(widget.event.attendees.length);
    return Scaffold(
      appBar: AppBar(title: const Text("Details Form")),
      body: LoadingWidget(
        isLoading: isLoading,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            const SizedBox(height: 20),
            const Text(
                "We need some details to register you for the event. Please fill the form below."),
            const SizedBox(height: 20),
            ...getFields(),
            const SizedBox(height: 20),
            ActionButton(
              text: "Submit",
              onPressed: () async {
                isLoading.value = true;
                setState(() {});
                final res = await http
                    .post(Uri.parse("$API_URL/users/registerForEvent"), body: {
                  "eventId": widget.event.id,
                  "userId": appState.value.user!.id,
                });
                isLoading.value = false;
                setState(() {});

                if (res.statusCode == 200 && mounted) {
                  showModalBottomSheet(
                    isDismissible: false,
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        height: 0.4 * MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Form Submitted Successfully",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 0.025 * getHeight(context)),
                            SvgPicture.asset(
                              "assets/done.svg",
                              height: 0.2 * getHeight(context),
                            ),
                            SizedBox(height: 0.025 * getHeight(context)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: ActionButton(
                                isFilled: false,
                                text: "Close",
                                onPressed: () {
                                  goToPage(context, const HomePage(),
                                      clearStack: true);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  getFields() {
    return formModel["fields"]!.map((field) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: CustomTextField(
          label: field["title"] ?? "None",
        ),
      );
    }).toList();
  }
}
