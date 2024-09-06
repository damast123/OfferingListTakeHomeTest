import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:offeringlist/app/data/models/offer.dart';
import 'package:offeringlist/app/modules/home/controllers/home_controller.dart';
import 'package:offeringlist/app/modules/offerlist/provider/OfferList.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// Mock class for Connectivity
class MockConnectivityPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements ConnectivityPlatform {
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return kCheckConnectivityResult;
  }
}

class MockOfferListProvider extends Mock implements OfferListProvider {}

const List<ConnectivityResult> kCheckConnectivityResult = [
  ConnectivityResult.wifi
];

void main() {
  Get.testMode = true;
  TestWidgetsFlutterBinding.ensureInitialized();

  late Connectivity connectivity;
  MockConnectivityPlatform fakePlatform;
  late HomeController homeController;
  late MockOfferListProvider mockOfferListProvider;

  setUp(() async {
    fakePlatform = MockConnectivityPlatform();
    ConnectivityPlatform.instance = fakePlatform;
    connectivity = Connectivity();

    fakePlatform = MockConnectivityPlatform();
    ConnectivityPlatform.instance = fakePlatform;

    mockOfferListProvider = MockOfferListProvider();
    homeController = Get.put(HomeController());
    homeController.offerListProvider = mockOfferListProvider;
  });

  group('Connectivity', () {
    test('checkConnectivity', () async {
      final result = await connectivity.checkConnectivity();
      expect(result, kCheckConnectivityResult);
    });
  });

  group('Controller Home', () {
    // comment Get.snackbar first on home_controller buyOffer to test this
    test('buyOffer shows loading, waits for async task, and stops loading',
        () async {
      // Initially, isLoading should be false
      expect(homeController.isLoading.value, false);

      final future = homeController.buyOffer();

      // After starting the async task, isLoading should be true
      await Future.delayed(const Duration(
          milliseconds: 100)); // Wait a bit to ensure the state change
      expect(homeController.isLoading.value, true);

      // Wait for the async task to complete
      await future;

      // After the task is done, isLoading should be false again
      expect(homeController.isLoading.value, false);
    });

    test('HomeController fetches offers and updates state correctly', () async {
      // Mock API call
      await homeController.getOfferListHome();
      expect(homeController.allOfferList.isNotEmpty, true);
      expect(homeController.isLoading.value, false);
    });

    test('deleteOffer removes offer from list and shows success message',
        () async {
      // Mock successful deletion
      when(mockOfferListProvider.deleteOfferList('66d977669b155f53b25f4e29'))
          .thenAnswer((_) async => 'success');

      // Add offer to the list first
      homeController.allOfferList
          .add(Offer(id: '166d977669b155f53b25f4e29', title: 'Test Offer'));
      expect(homeController.allOfferList.length, 1);

      await homeController.deleteOffer('66d977669b155f53b25f4e29');

      // Check that the offer is removed
      expect(homeController.allOfferList.length, 0);
    });
  });
}
