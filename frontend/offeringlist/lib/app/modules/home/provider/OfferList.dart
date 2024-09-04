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
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
      }
      rethrow;
    }
  }

  Future<List<Offer>> getOfferList(String id) async {
    try {
      final response = await dio.get('offers/$id');
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
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.d(e.requestOptions);
        logger.d(e.message);
      }
      rethrow;
    }
  }

  // Future<Offer> addNewOffer(String name, String job) async {
  //   try {
  //     final response = await dio.post(
  //       '/offers',
  //       data: {
  //         'name': name,
  //         'job': job,
  //       },
  //     );
  //     return Offer.fromJson(response);
  //   } on DioException catch (e) {
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx and is also not 304.
  //     if (e.response != null) {
  //       logger.d(e.response?.data);
  //       logger.d(e.response?.headers);
  //       logger.d(e.response?.requestOptions);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       logger.d(e.requestOptions);
  //       logger.d(e.message);
  //     }
  //     rethrow;
  //   }
  // }

  // Future<Offer> updateOfferList(String id, String name, String job) async {
  //   try {
  //     final response = await DioClient.instance.put(
  //       'offers/$id',
  //       data: {
  //         'id': id,
  //         'name': name,
  //         'job': job,
  //       },
  //     );
  //     return Offer.fromJson(response);
  //   } on DioException catch (e) {
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx and is also not 304.
  //     if (e.response != null) {
  //       logger.d(e.response?.data);
  //       logger.d(e.response?.headers);
  //       logger.d(e.response?.requestOptions);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       logger.d(e.requestOptions);
  //       logger.d(e.message);
  //     }
  //     rethrow;
  //   }
  // }

  // Future<void> deleteOfferList(String id) async {
  //   try {
  //     await DioClient.instance.delete('offers/$id');
  //   } on DioException catch (e) {
  //     // The request was made and the server responded with a status code
  //     // that falls out of the range of 2xx and is also not 304.
  //     if (e.response != null) {
  //       logger.d(e.response?.data);
  //       logger.d(e.response?.headers);
  //       logger.d(e.response?.requestOptions);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       logger.d(e.requestOptions);
  //       logger.d(e.message);
  //     }
  //     rethrow;
  //   }
  // }
}
