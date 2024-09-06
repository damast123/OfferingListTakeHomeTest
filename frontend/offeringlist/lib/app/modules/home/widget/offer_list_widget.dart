import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/offer.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

Widget offerListWidget(bool isTablet) {
  final HomeController _getHomeController = Get.find();
  return ListView.separated(
    padding: const EdgeInsets.all(8.0),
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      Offer offer = _getHomeController.allOfferList[index];
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          leading: const Icon(Icons.local_offer,
              color: Colors.blueAccent, size: 34.0),
          title: Text(
            offer.title!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            offer.description ?? "No description",
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: SizedBox(
            width: isTablet ? Get.width * 0.3 : Get.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 32.0,
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Delete Offer",
                      middleText: "Are you sure you want to delete this offer?",
                      onConfirm: () {
                        _getHomeController.deleteOffer(offer.id!);
                      },
                      textConfirm: "Delete",
                      textCancel: "Cancel",
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.trash_circle_fill,
                    color: Colors.red,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Buying Offer",
                      middleText: "Are you sure you want to buy this offer?",
                      onConfirm: () async =>
                          await _getHomeController.buyOffer(),
                      onCancel: () => Get.back(),
                      textConfirm: "Confirm",
                      textCancel: "Cancel",
                    );
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            String id = offer.id!;
            Get.toNamed(
              Routes.OFFERLIST,
              arguments: [
                {
                  'mode': 'view',
                  'id': id,
                },
              ],
            );
          },
        ),
      );
    },
    separatorBuilder: (context, index) => const Divider(),
    itemCount: _getHomeController.allOfferList.length,
  );
}


// Widget offerListWidget({bool? isTablet}) {
//   final HomeController _getHomeController = Get.find();
//   return ListView.separated(
//     padding: const EdgeInsets.all(8.0),
//     shrinkWrap: true,
//     itemBuilder: (BuildContext context, int index) {
//       Offer offer = _getHomeController.allOfferList[index];
//       return Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ListTile(
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           leading: const Icon(Icons.local_offer,
//               color: Colors.blueAccent, size: 34.0),
//           title: Text(
//             offer.title!,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           subtitle: Text(
//             offer.description ?? "No description",
//             style: const TextStyle(color: Colors.grey),
//           ),
//           trailing: SizedBox(
//             width: Get.width * 0.34,
//             child: Row(
//               children: [
//                 IconButton(
//                   iconSize: 32.0,
//                   onPressed: () {
//                     Get.defaultDialog(
//                       title: "Delete Offer",
//                       middleText: "Are you sure you want to delete this offer?",
//                       onConfirm: () {
//                         _getHomeController.deleteOffer(offer.id!);
//                       },
//                       textConfirm: "Delete",
//                       textCancel: "Cancel",
//                     );
//                   },
//                   icon: const Icon(
//                     CupertinoIcons.trash_circle_fill,
//                     color: Colors.red,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Get.defaultDialog(
//                       title: "Buying Offer",
//                       middleText: "Are you sure you want to buy this offer?",
//                       onConfirm: () async =>
//                           await _getHomeController.buyOffer(),
//                       onCancel: () => Get.back(),
//                       textConfirm: "Confirm",
//                       textCancel: "Cancel",
//                     );
//                   },
//                   child: const Text(
//                     "Buy Now",
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           onTap: () {
//             String id = offer.id!;
//             Get.toNamed(
//               Routes.OFFERLIST,
//               arguments: [
//                 {
//                   'mode': 'view',
//                   'id': id,
//                 },
//               ],
//             );
//           },
//         ),
//       );
//     },
//     separatorBuilder: (context, index) => const Divider(),
//     itemCount: _getHomeController.allOfferList.length,
//   );
// }
