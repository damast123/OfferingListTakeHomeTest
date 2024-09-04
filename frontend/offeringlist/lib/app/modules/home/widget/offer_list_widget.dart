import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/offer.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

Widget offerListWidget(BuildContext ctx) {
  final HomeController _getHomeController = Get.find();
  return ListView.separated(
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      Offer offer = _getHomeController.allOfferList[index];
      return ListTile(
        title: Text(offer.title ?? "No title"),
        subtitle: Text(offer.description ?? "No description"),
        onTap: () {
          String id = offer.title!;
          Get.toNamed(
            Routes.OFFERLIST,
            arguments: [
              {
                'id': id,
              },
            ],
          );
        },
      );
    },
    separatorBuilder: (context, index) => const Divider(),
    itemCount: _getHomeController.allOfferList.length,
  );
}
