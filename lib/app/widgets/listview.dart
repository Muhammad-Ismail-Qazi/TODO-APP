import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../modules/home/controllers/home_controller.dart';

class CustomListView extends StatelessWidget {
  final HomeController controller;
  final String title;
  final String description;
  final String date;
  final bool status;
  final int id ;
  const CustomListView({
    super.key,
    required this.controller,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) {
              controller.removeItemAtIndex(id);
            },
          )
        ],
      ),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          Expanded(child: Text(description.toString())),
        ],
      ),
      child: Obx(
        () => CheckboxListTile(
          value: status.obs.value,
          onChanged: (bool? value) {
            controller.toggleCheckBoxStateAtIndex(id);
          },
          title: Text(title.toString()),
          contentPadding: const EdgeInsets.all(12),
          subtitle: Text(date.toString()),
          tileColor: Colors.black12,
        ),
      ),
    );
  }
}