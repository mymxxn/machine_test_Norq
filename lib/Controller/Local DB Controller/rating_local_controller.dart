import 'package:get/get.dart';
import 'package:machine_test/Model/product_list_model.dart';
import 'package:machine_test/Services/DB%20helper/db_helper.dart';

class RatingLocalController extends GetxController {
  insertRating({required RatingModel rating}) async {
    await DBHelper().insertRateing(rateing: rating);
  }

  deletRating({required int id}) async {
    await DBHelper().deleteRating(id: id);
  }
}
