import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../offerlist/provider/OfferList.dart';

class OfferListController extends GetxController {
  final formKey = GlobalKey<FormState>();

  HomeController homeController = Get.find();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final discountPercentageController = TextEditingController();
  final originalPriceController = TextEditingController();
  final discountedPriceController = TextEditingController();

  OfferListProvider offerListProvider = new OfferListProvider();

  var isEditMode = false.obs;
  final isLoading = true.obs;

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Collecting form data
      String title = titleController.text;
      String? description = descriptionController.text;
      double discountPercentage =
          double.parse(discountPercentageController.text);
      double originalPrice = double.parse(originalPriceController.text);
      double discountedPrice = double.parse(discountedPriceController.text);

      offerListProvider
          .addNewOffer(title, description, discountPercentage, originalPrice,
              discountedPrice)
          .then((result) {
        if (result == 'success') {
          Get.defaultDialog(
            title: 'Form Submitted',
            middleText:
                'Title: $title\nDescription: $description\nDiscount: $discountPercentage%\nOriginal Price: Rp.$originalPrice\nDiscounted Price: Rp.$discountedPrice',
            onConfirm: () => Get.back(),
            textConfirm: "Ok",
          );
        } else {
          Get.defaultDialog(
            title: 'Error submit',
            middleText: result,
            onConfirm: () => Get.back(),
            textConfirm: "Ok",
          );
        }
      });
    }
  }

  void getOfferListDetail(String id) async {
    try {
      isLoading.value = true;
      var data = await offerListProvider.getOfferList(id);

      titleController.text = data.title ?? ''; // Handle null title
      descriptionController.text =
          data.description ?? ''; // Handle null description
      discountPercentageController.text = data.discountPercentage.toString();
      originalPriceController.text = data.originalPrice.toString();
      discountedPriceController.text = data.discountedPrice.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateOfferDetails(String id) {
    if (formKey.currentState!.validate()) {
      String title = titleController.text;
      String? description = descriptionController.text;
      double discountPercentage =
          double.parse(discountPercentageController.text);
      double originalPrice = double.parse(originalPriceController.text);
      double discountedPrice = double.parse(discountedPriceController.text);

      offerListProvider
          .updateOfferList(id, title, description, discountPercentage,
              originalPrice, discountedPrice)
          .then((result) {
        if (result == 'success') {
          Get.defaultDialog(
            title: 'Form updated',
            middleText: 'Form has been updated successfully',
            onConfirm: () {
              Get.back();
            },
            textConfirm: "Ok",
          );
        } else {
          Get.defaultDialog(
            title: 'Error update',
            middleText: result,
            onConfirm: () {
              Get.back();
            },
            textConfirm: "Ok",
          );
        }
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    final argument = Get.arguments;
    if (argument[0]['mode'] == 'view') {
      getOfferListDetail(argument[0]['id']);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    discountPercentageController.dispose();
    originalPriceController.dispose();
    discountedPriceController.dispose();
    homeController.getOfferListHome();
    super.onClose();
  }
}
