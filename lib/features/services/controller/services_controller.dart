import 'package:get/get.dart';
import '../model/services_model.dart';
import '../repo/services_repository.dart';

class ServicesController extends GetxController {
  final ServicesRepository _repository = ServicesRepository();

  var isLoading = false.obs;
  var categories = <ServiceCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() async {
    try {
      isLoading(true);
      // Repository मधून डेटा लोड करणे (भविष्यात API इंटिग्रेशन सोपे होईल)
      var fetchedCategories = await _repository.fetchCategories();
      categories.assignAll(fetchedCategories);
    } finally {
      isLoading(false);
    }
  }
}
