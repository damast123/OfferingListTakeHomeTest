import 'package:get/get.dart';

import '../controllers/offerlist_controller.dart';

class OfferListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferListController>(
      () => OfferListController(),
    );
  }
}
