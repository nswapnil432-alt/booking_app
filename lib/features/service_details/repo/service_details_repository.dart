import '../model/service_details_model.dart';

class ServiceDetailsRepository {
  Future<List<ArtistModel>> fetchArtistsByCategory(String categoryTitle) async {
    // स्क्रीनशॉटमधील मूळ डेटा मॅप केला आहे
    if (categoryTitle.toLowerCase() == "vocalist") {
      return [
        ArtistModel(
          name: "Artist A",
          city: "City 1",
          experienceYears: 18,
          rating: 4.8,
          ratingCount: 124,
          pricePerEvent: "₹15,000",
          imageUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80",
        ),
        ArtistModel(
          name: "Artist D",
          city: "City 4",
          experienceYears: 10,
          rating: 4.7,
          ratingCount: 67,
          pricePerEvent: "₹9,000",
          imageUrl: "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=300&q=80",
        ),
      ];
    } else {
      // इतर सर्व कॅटेगरीजसाठी पूरक मॉक डेटा
      return [
        ArtistModel(
          name: "Artist B",
          city: "City 2",
          experienceYears: 8,
          rating: 4.9,
          ratingCount: 89,
          pricePerEvent: "₹12,000",
          imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80",
        ),
        ArtistModel(
          name: "Artist C",
          city: "City 3",
          experienceYears: 12,
          rating: 4.6,
          ratingCount: 45,
          pricePerEvent: "₹10,500",
          imageUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=300&q=80",
        ),
      ];
    }
  }
}
