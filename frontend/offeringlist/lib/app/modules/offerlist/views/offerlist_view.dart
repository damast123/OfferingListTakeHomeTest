import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/offerlist_controller.dart';

class OfferListView extends GetView<OfferListController> {
  const OfferListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Offer List'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OfferlistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
