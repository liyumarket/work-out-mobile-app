import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController/dialogsAndLoadingController.dart';
import 'package:work_out/helpers/string_methods.dart';
import 'package:work_out/model/categories_response.dart';
import 'package:work_out/service/dio_service.dart';
import 'package:work_out/service/local_storage_service.dart';

class CategoryController extends GetxController {
  final DioService _dioService = DioService();
  Rx<CategoriesResponse> categories = CategoriesResponse().obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  DialogsAndLoadingController dialogsAndLoadingController = Get.find();
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading(true);
    try {
      String token = SharedPreferencesService().getValue('token');

      final response = await _dioService.getRequest(
          'http://128.140.107.116:4400/api/v1/admin/getAllCategory',
          headers: {'x-api-key': token});

      categories.value = CategoriesResponse.fromJson(response.data);

      errorMessage('');
    } on DioException catch (e) {
      debugPrint(e.toString());
      dialogsAndLoadingController.showError(
        capitalize(
          e.message ?? "Network error",
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      dialogsAndLoadingController.showError(
        capitalize(
          e.toString(),
        ),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCategoryById(int id) async {
    isLoading(true);
    try {
      String token = SharedPreferencesService().getValue('token');

      final response = await _dioService.getRequest(
          'http://128.140.107.116:4400/api/v1/admin/getAllVideosByCategory/$id',
          headers: {'x-api-key': token});

      categories.value = CategoriesResponse.fromJson(response.data);

      errorMessage('');
    } on DioException catch (e) {
      debugPrint(e.toString());
      dialogsAndLoadingController.showError(
        capitalize(
          e.message ?? "Network error",
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      dialogsAndLoadingController.showError(
        capitalize(
          e.toString(),
        ),
      );
    } finally {
      isLoading(false);
    }
  }
}
