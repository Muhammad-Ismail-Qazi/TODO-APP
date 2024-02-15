import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool isSearching = false.obs;
  RxBool isCheckBox = false.obs;
  late DateTime pickDate;
  String? formatedDate;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxList<ToDoModel> toDo = <ToDoModel>[].obs;
  RxList<ToDoModel> filterTodo = <ToDoModel>[].obs;
  int id = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool toggleSearchingState() {
    isSearching.value = !isSearching.value;
    return isSearching.value;
  }

  void toggleCheckBoxStateAtIndex(int index) {
    toDo.indexWhere((index) {
      if (index.id == index) {
        return isCheckBox.value = true;
      } else {
        return isCheckBox.value = false;
      }
    });
  }


  Future<String?> selectDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );

    if (pickDate != null) {
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');

     formatedDate = dateFormat.format(pickDate);

      return formatedDate;
    }
    return '';
  }

  void todoData() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      toDo.add(ToDoModel(
        id: id++,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: formatedDate,
        status: isCheckBox.value,
        onDelete: (index) {
          removeItemAtIndex(toDo.indexWhere((index) => index.id == index));
          Get.snackbar('Delete',' Successfully delete');
        },
      ));

      // Clear fields after adding data
      titleController.clear();
      descriptionController.clear();
      formatedDate = ''; // Reset the date format value
    }
  }

  searchTask(String value) {
    if (value.isEmpty) {
      filterTodo.addAll(toDo);
    } else {
      filterTodo.addAll(toDo.where(
          (title) => title.title!.toLowerCase().contains(value.toLowerCase())));
    }
  }

  void removeItemAtIndex(int index) {
    if (index >= 0 && index < toDo.length) {
      toDo.removeAt(index);
    }
  }
}