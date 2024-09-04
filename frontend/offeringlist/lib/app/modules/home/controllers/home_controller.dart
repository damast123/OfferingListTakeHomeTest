import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../data/models/offer.dart';
import '../../../data/config/config.dart';
import '../provider/OfferList.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;

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

  void increment() => count.value++;
}
