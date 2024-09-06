import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../widget/offer_list_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GetBuilder<HomeController>(builder: (homeControllers) {
          if (homeControllers.checkConnectivity() == false) {
            controller.showConnectivityDialog(context);
            return const Center(child: CircularProgressIndicator());
          }
          return Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.allOfferList.isEmpty) {
              return const Center(child: Text("No offers available"));
            }

            return LayoutBuilder(builder: (context, sized) {
              return Column(
                children: [
                  Expanded(
                    child: offerListWidget(),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Get.toNamed(
                        Routes.OFFERLIST,
                        arguments: [
                          {
                            'mode': 'add',
                          },
                        ],
                      );
                    },
                    label: const Text("Add Offer"),
                  ),
                ],
              );
            });
          });
        }),
      ),
    );
  }
}
