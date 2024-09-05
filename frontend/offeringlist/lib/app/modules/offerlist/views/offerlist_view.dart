import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../widget/addOffer.dart';
import '../widget/detailOffer.dart';

import '../controllers/offerlist_controller.dart';

class OfferListView extends GetView<OfferListController> {
  OfferListView({super.key});
  final argument = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: argument[0]['mode'] == 'view'
            ? const Text('Detail Offer List')
            : const Text('Create Offer List'),
        centerTitle: true,
        actions: [
          if (argument[0]['mode'] == 'view')
            Obx(() {
              return IconButton(
                icon: Icon(controller.isEditMode.value
                    ? Icons.remove_red_eye
                    : Icons.edit),
                onPressed: () {
                  controller.isEditMode.toggle();
                },
              );
            }),
        ],
      ),
      body: Center(
        child: argument[0]['mode'] == 'view'
            ? detailOffer(context, argument[0]['id'])
            : addOffer(context),
      ),
    );
  }
}
