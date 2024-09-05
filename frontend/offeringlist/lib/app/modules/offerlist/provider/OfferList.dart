import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../data/config/config.dart';
import '../../../data/models/offer.dart';

class OfferListProvider extends GetConnect {
  final options = BaseOptions(
    baseUrl: api,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );
  late final Dio dio;

  OfferListProvider() {
    dio = Dio(options);
  }

  Future<List<Offer>> getAllOfferList() async {
    try {
      final response = await dio.get('offers');
      final userList =
          (response.data as List).map((e) => Offer.fromJson(e)).toList();
      return userList;
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.d(e.response?.data);
        logger.d(e.response?.headers);
        logger.d(e.response?.requestOptions);
        Get.defaultDialog(title: "Error", middleText: e.response?.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
        Get.defaultDialog(title: "Error", middleText: e.message!);
      }
      rethrow;
    }
  }

  Future<String> deleteOfferList(String id) async {
    try {
      await dio.delete('offers/$id');
      return 'success';
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.d(e.response?.data);
        logger.d(e.response?.headers);
        logger.d(e.response?.requestOptions);
        Get.defaultDialog(title: "Error", middleText: e.response?.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
        Get.defaultDialog(title: "Error", middleText: e.message!);
      }
      rethrow;
    }
  }

  Future<Offer> getOfferList(String id) async {
    try {
      final response = await dio.get('offers/$id');
      logger.d(response.data['data']['offer']);
      return Offer.fromJson(response.data['data']['offer']);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.d(e.response?.data);
        logger.d(e.response?.headers);
        logger.d(e.response?.requestOptions);
        Get.defaultDialog(title: "Error", middleText: e.response?.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
        Get.defaultDialog(title: "Error", middleText: e.message!);
      }
      rethrow;
    }
  }

  Future<String> addNewOffer(
      String title,
      String? description,
      double discountPercentage,
      double originalPrice,
      double discountedPrice) async {
    try {
      await dio.post(
        '/offers',
        data: {
          'title': title,
          'description': description,
          'discountPercentage': discountPercentage,
          'originalPrice': originalPrice,
          'discountedPrice': discountedPrice,
        },
      );
      return 'success';
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.d(e.response?.data);
        logger.d(e.response?.headers);
        logger.d(e.response?.requestOptions);
        Get.defaultDialog(title: "Error", middleText: e.response?.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
        Get.defaultDialog(title: "Error", middleText: e.message!);
      }
      throw e.message!;
    }
  }

  Future<String> updateOfferList(
    String id,
    String title,
    String? description,
    double discountPercentage,
    double originalPrice,
    double discountedPrice,
  ) async {
    try {
      await dio.put(
        '/offers/$id',
        data: {
          'title': title,
          'description': description,
          'discountPercentage': discountPercentage,
          'originalPrice': originalPrice,
          'discountedPrice': discountedPrice,
        },
      );
      return 'success';
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.d(e.response?.data);
        logger.d(e.response?.headers);
        logger.d(e.response?.requestOptions);
        Get.defaultDialog(title: "Error", middleText: e.response?.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
        Get.defaultDialog(title: "Error", middleText: e.message!);
      }
      rethrow;
    }
  }
}
