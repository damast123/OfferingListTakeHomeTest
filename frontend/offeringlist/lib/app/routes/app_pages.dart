import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/offerlist/bindings/offerlist_binding.dart';
import '../modules/offerlist/views/offerlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.OFFERLIST,
      page: () => OfferListView(),
      binding: OfferListBinding(),
    ),
  ];
}
