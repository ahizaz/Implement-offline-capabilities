import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';

class HomeScreen extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Offline Data Example')),
      body: Obx(() {
        if (itemController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: itemController.items.length,
          itemBuilder: (context, index) {
            final item = itemController.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('ID: ${item.id}'),
            );
          },
        );
      }),
    );
  }
}