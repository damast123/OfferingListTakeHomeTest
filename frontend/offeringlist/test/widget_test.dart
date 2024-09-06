import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:offeringlist/app/modules/home/controllers/home_controller.dart';
import 'package:offeringlist/app/modules/home/widget/offer_list_widget.dart';

void main() {
  Get.testMode = true;
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    Get.put(HomeController());
  });

  testWidgets('Offers List displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: Scaffold(body: offerListWidget()),
      ),
    );
    expect(find.text('No offers available'), findsNothing);
  });
}
