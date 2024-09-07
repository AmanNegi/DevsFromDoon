import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future goToPage(BuildContext context, Widget destination,
    {bool clearStack = false}) {
  if (clearStack) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination), (route) => false);
  }
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

showToast(String message) {
  Fluttertoast.showToast(msg: message);
}

double getWidth(context) => MediaQuery.of(context).size.width;
double getHeight(context) => MediaQuery.of(context).size.height;

LinearGradient shimmerGradient = LinearGradient(colors: [
  Colors.grey.shade300,
  Colors.grey.shade100,
  Colors.grey.shade300,
]);

const API_URL = "https://964e-152-59-118-43.ngrok-free.app/api";
const eventImages = [
  'https://exchange4media.gumlet.io/news-photo/133240-big.jpg',
  'https://edexec.co.uk/wp-content/uploads/2020/02/iStock-1031459248-2.jpg',
  'https://i.pinimg.com/736x/43/23/27/432327f68a83f9911cb25fea765e9252.jpg',
  'https://img.freepik.com/premium-photo/young-adults-coding-together-hackathon-event_706399-17099.jpg',
];
