import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lpu_events/utils/firebase_storage.dart';
import 'package:lpu_events/widgets/action_button.dart';
import 'package:lpu_events/widgets/loading_widget.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  AddItemPageState createState() => AddItemPageState();
}

class AddItemPageState extends State<AddItemPage> {
  late double height, width;

  String name = "", description = "";
  double price = 0.0;
  String imageUrl = "";
  bool pickedImage = false;
  bool isDownloadEnabled = false;
  bool isFree = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return LoadingWidget(
      isLoading: isLoading,
      child: _getAddEventPage(context),
    );
  }

  Scaffold _getAddEventPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Add Event",
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _getFloatingActionButton(context),
      body: _getBody(),
    );
  }

  _getFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        isLoading.value = true;
        String itemId = const Uuid().v1();

        // String url =
        //     await storageManager.uploadItemImage(itemId, File(imageUrl));

        // await addItem(
        //   name: name,
        //   listedBy: appState.value.user!.id,
        //   description: description,
        //   images: [url],
        //   price: price,
        // );
        isLoading.value = false;
        if (mounted) {
          Navigator.pop(context);
        }
      },
      label: const Row(
        children: [
          Text("Continue"),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_forward_ios,
            size: 14,
          ),
        ],
      ),
    );
  }

  _getBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        height: height,
        child: Column(
          children: [
            SizedBox(height: 0.02 * height),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              reverseDuration: const Duration(seconds: 1),
              child: _getImageSelector(),
              layoutBuilder: (currentChild, previousChildren) =>
                  currentChild ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  _getImageSelector() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: SizedBox(
            height: 0.3 * height,
            width: double.infinity,
            child: pickedImage
                ? GestureDetector(
                    onTap: () {
                      pickAnImage();
                    },
                    child: Image.file(
                      File(imageUrl),
                      fit: BoxFit.contain,
                    ),
                  )
                : ActionButton(
                    onPressed: () async {
                      await pickAnImage();
                    },
                    text: ("Pick an Image"),
                  ),
          ),
        ),
        Container(
          height: 0.025 * height,
        ),
        _getTextField(
          "Name",
          ((e) => name = e),
          TextInputType.text,
        ),
        _getTextField(
          "Description",
          ((e) => description = e),
          TextInputType.text,
        ),
        _getTextField(
          "Price",
          ((e) => price = double.parse(e)),
          TextInputType.number,
        ),
        _getTextField(
          "Venue",
          ((e) => price = double.parse(e)),
          TextInputType.number,
        ),
        // Date Picker
        ListTile(
          title: Text(
            selectedDate == null
                ? "Select Date"
                : DateFormat.yMMMd().format(selectedDate!),
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: () => _selectDate(context),
        ),
        ListTile(
          title: Text(
            selectedTime == null
                ? "Select Time"
                : selectedTime!.format(context),
          ),
          trailing: const Icon(Icons.access_time),
          onTap: () => _selectTime(context),
        ),

        SwitchListTile(
          title: const Text("Duty Leave"),
          value: isDownloadEnabled,
          onChanged: (bool value) {
            setState(() {
              isDownloadEnabled = value;
            });
          },
        ),
      ],
    );
  }

  _getTextField(
    String hintText,
    Function onChange,
    TextInputType keyboardType,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            spreadRadius: 1.0,
            blurRadius: 8.0,
          ),
        ],
      ),
      child: TextField(
        maxLines: null,
        keyboardType: keyboardType,
        onChanged: (value) {
          onChange(value);
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Future<bool> pickAnImage() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (file != null) {
      imageUrl = file.path;
      pickedImage = true;
      setState(() {});
      return true;
    }
    return false;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}
