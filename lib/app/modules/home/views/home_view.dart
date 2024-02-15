import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../../../widgets/listview.dart';
import '../../../widgets/textfield.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Data are");
    print(controller.toDo);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(),
        drawer:  buildDrawer(),
        body: TabBarView(
          children: [
            Obx(() {
              if (controller.toDo.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (context, index) {

                    if (controller.toDo.isNotEmpty &&
                        controller.toDo[index].status == false) {
                      return CustomListView(
                        controller: controller,
                        title: controller.toDo[index].title.toString(),
                        description: controller.toDo[index].description.toString(),
                        date: controller.toDo[index].dateTime.toString(),
                        status: controller.toDo[index].status!,
                        id: index,
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: controller.toDo.length,
                );
              } else {
                return const Center(child: Text("No task has been created"));
              }
            }),
            Obx(() {
              if (controller.toDo.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    if (controller.toDo.isNotEmpty &&
                        controller.toDo[index].status == true) {
                      return CustomListView(
                        controller: controller,
                        title: controller.toDo[index].title.toString(),
                        description:
                            controller.toDo[index].description.toString(),
                        date: controller.toDo[index].dateTime!,
                        status: controller.toDo[index].status!,
                        id: index,
                      );
                    }
                    return null;
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: controller.toDo.length,
                );
              } else {
                return const Center(child: Text("No task has been completed"));
              }
            }),
          ],
        ),
        floatingActionButton: AvatarGlow(
          glowColor: Colors.black,
          curve: Curves.decelerate,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              buildDefaultDialog(context);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    return const Drawer(

        child: DrawerHeader(

          padding: EdgeInsets.all(0),
          curve: Curves.bounceInOut,
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text("Muhammad Ismail"),
                  accountEmail: Text("muhammad.ismail15604@gmail.com"),
                currentAccountPicture: CircleAvatar(),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),

            ],
          ),
        ),
      );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Obx(
        () => controller.isSearching.value
            ? TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                onChanged: (value) {
                  controller.searchTask(value);
                },
              )
            : const Text('TODO'),
      ),
      centerTitle: true,
      bottom: const TabBar(
        dividerColor: Colors.transparent,
        tabs: [
          Text("All Task"),
          Text("Complete"),
        ],
      ),
      actions: [
        Obx(
          () {
            return IconButton(
              onPressed: () {
                controller.toggleSearchingState();
              },
              icon: Icon(
                  controller.isSearching.value ? Icons.close : Icons.search),
            );
          },
        ),
      ],
    );
  }

  Future<dynamic> buildDefaultDialog(BuildContext context) {
    return Get.defaultDialog(
      title: "Add Task",
      content: Column(
        children: [
          CustomTextField(
            hintText: 'Title',
            fieldController: controller.titleController,
          ),
          const SizedBox(height: 12),
          CustomTextField(
            hintText: 'Description',
            fieldController: controller.descriptionController,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              controller.selectDate(context);
            },
            child: const Text('Select End Date'),
          ),
          Obx(
            ()=> Text(controller.formatedDate.obs.value != null ? controller.formatedDate!:"No date selected"),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.all(12),
      textConfirm: 'Add',
      confirmTextColor: Colors.white,
      textCancel: 'Cancel',
      onCancel: (){
        controller.titleController.clear();
        controller.descriptionController.clear();
        controller.formatedDate=null;
      },
      onConfirm: () {
        controller.todoData();
        Get.snackbar("Success", "New task is added");
      },
    );
  }
}