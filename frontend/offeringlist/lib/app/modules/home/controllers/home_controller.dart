import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../data/models/offer.dart';
import '../../offerlist/provider/OfferList.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final isLoading = true.obs;

  RxList allOfferList = List<Offer>.empty(growable: true).obs;

  OfferListProvider offerListProvider = new OfferListProvider();

  Future<bool> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  void showConnectivityDialog(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.dialog(
        AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text('Please check your internet settings.'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  void getOfferListHome() async {
    try {
      isLoading.value = true;
      var data = await offerListProvider.getAllOfferList();
      allOfferList.assignAll(data);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> buyOffer() async {
    isLoading.value = true;
    Get.back();
    // Simulate an async task (e.g., an API call)
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;

    Get.snackbar("Offer Buy", "Offer Buy has been successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 6));
  }

  Future<void> deleteOffer(String id) async {
    try {
      isLoading.value = true;
      String result = await offerListProvider.deleteOfferList(id);
      if (result == 'success') {
        allOfferList.removeWhere((offer) => offer.id == id);
        Get.back();
        Get.snackbar('Success', 'Offer deleted successfully!',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete offer: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOfferListHome();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
