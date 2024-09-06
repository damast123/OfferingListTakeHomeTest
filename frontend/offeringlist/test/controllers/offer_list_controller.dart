import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:offeringlist/app/data/models/offer.dart';
import 'package:offeringlist/app/modules/home/controllers/home_controller.dart';
import 'package:offeringlist/app/modules/offerlist/controllers/offerlist_controller.dart';
import 'package:offeringlist/app/modules/offerlist/provider/OfferList.dart';

class MockOfferListProvider extends Mock implements OfferListProvider {}

class MockHomeController extends Mock implements HomeController {}

void main() {
  Get.testMode = true;
  TestWidgetsFlutterBinding.ensureInitialized();

  late OfferListController offerListController;
  late MockOfferListProvider mockOfferListProvider;
  late MockHomeController mockHomeController;

  setUp(() {
    mockOfferListProvider = MockOfferListProvider();
    mockHomeController = MockHomeController();
    offerListController = Get.put(OfferListController());

    offerListController.offerListProvider = mockOfferListProvider;
    offerListController.homeController = mockHomeController;
  });

  test('submitForm shows success dialog on successful submission', () async {
    when(mockOfferListProvider.addNewOffer(
            'Test Title', 'Test Description', 10, 100, 90))
        .thenAnswer((_) async => 'success');

    offerListController.titleController.text = 'Test Title';
    offerListController.descriptionController.text = 'Test Description';
    offerListController.discountPercentageController.text = '10';
    offerListController.originalPriceController.text = '100';
    offerListController.discountedPriceController.text = '90';

    offerListController.submitForm();

    await Future.delayed(
        Duration(milliseconds: 100)); // Allow async operations to complete

    expect(find.byType(AlertDialog), findsOneWidget);
    final dialog =
        find.byType(AlertDialog).evaluate().single.widget as AlertDialog;
    expect(dialog.title, 'Form Submitted');
  });

  test('getOfferListDetail sets controllers with data', () async {
    final offer = Offer(
      title: 'Test Title',
      description: 'Test Description',
      discountPercentage: 10,
      originalPrice: 100,
      discountedPrice: 90,
    );

    when(mockOfferListProvider.getOfferList('66d976ff9b155f53b25f4e24'))
        .thenAnswer((_) async => offer);

    await offerListController.getOfferListDetail('66d976ff9b155f53b25f4e24');

    expect(offerListController.titleController.text, 'Test Title');
    expect(offerListController.descriptionController.text, 'Test Description');
    expect(offerListController.discountPercentageController.text, '10');
    expect(offerListController.originalPriceController.text, '100');
    expect(offerListController.discountedPriceController.text, '90');
  });

  test('updateOfferDetails shows success dialog on successful update',
      () async {
    when(mockOfferListProvider.updateOfferList('66d976ff9b155f53b25f4e24',
            'Updated Title', 'Updated Description', 15, 200, 170))
        .thenAnswer((_) async => 'success');

    offerListController.titleController.text = 'Updated Title';
    offerListController.descriptionController.text = 'Updated Description';
    offerListController.discountPercentageController.text = '15';
    offerListController.originalPriceController.text = '200';
    offerListController.discountedPriceController.text = '170';

    offerListController.updateOfferDetails('66d976ff9b155f53b25f4e24');

    await Future.delayed(
        Duration(milliseconds: 100)); // Allow async operations to complete

    expect(find.byType(AlertDialog), findsOneWidget);
    final dialog =
        find.byType(AlertDialog).evaluate().single.widget as AlertDialog;
    expect(dialog.title, 'Form updated');
  });
}
