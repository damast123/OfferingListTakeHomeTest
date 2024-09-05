import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/offerlist_controller.dart';

Widget detailOffer(BuildContext ctx, String id) {
  final OfferListController _getOfferController = Get.find();
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Form(
      key: _getOfferController.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title Input

            Obx(
              () => TextFormField(
                controller: _getOfferController.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                enabled: _getOfferController.isEditMode.value,
              ),
            ),
            const SizedBox(height: 16),

            // Description Input
            Obx(
              () => TextFormField(
                controller: _getOfferController.descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                enabled: _getOfferController.isEditMode.value,
              ),
            ),
            const SizedBox(height: 16),

            // Discount Percentage Input
            Obx(
              () => TextFormField(
                controller: _getOfferController.discountPercentageController,
                decoration:
                    const InputDecoration(labelText: 'Discount Percentage (%)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Discount Percentage is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                enabled: _getOfferController.isEditMode.value,
              ),
            ),
            const SizedBox(height: 16),

            // Original Price Input
            Obx(
              () => TextFormField(
                controller: _getOfferController.originalPriceController,
                decoration: const InputDecoration(labelText: 'Original Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Original Price is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                enabled: _getOfferController.isEditMode.value,
              ),
            ),
            const SizedBox(height: 16),

            // Discounted Price Input
            Obx(
              () => TextFormField(
                controller: _getOfferController.discountedPriceController,
                decoration:
                    const InputDecoration(labelText: 'Discounted Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Discounted Price is required';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                enabled: _getOfferController.isEditMode.value,
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            Obx(() {
              return Visibility(
                visible: _getOfferController.isEditMode.value,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_getOfferController.formKey.currentState
                              ?.validate() ??
                          false) {
                        _getOfferController.updateOfferDetails(id);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    ),
  );
}
