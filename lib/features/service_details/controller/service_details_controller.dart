import 'package:get/get.dart';
import '../model/service_details_model.dart';
import '../repo/service_details_repository.dart';

class ServiceDetailsController extends GetxController {
  final ServiceDetailsRepository _repository = ServiceDetailsRepository();
  final String categoryTitle;

  ServiceDetailsController({required this.categoryTitle});

  var isLoading = false.obs;
  var artists = <ArtistModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadArtists();
  }

  void loadArtists() async {
    try {
      isLoading(true);
      var fetchedArtists = await _repository.fetchArtistsByCategory(categoryTitle);
      artists.assignAll(fetchedArtists);
    } finally {
      isLoading(false);
    }
  }
}
