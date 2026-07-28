import 'package:flutter/material.dart';
import '../model/services_model.dart';

class ServicesRepository {
  Future<List<ServiceCategory>> fetchCategories() async {
    // API कॉल ऐवजी तात्पुरता मॉक डेटा रिझॉल्व्ह केला आहे, जो हुबेहूब स्क्रीनशॉटशी मॅच होतो
    return [
      ServiceCategory(
        title: "Vocalist",
        description: "Solo and group vocal performers",
        icon: Icons.mic_external_on_outlined,
      ),
      ServiceCategory(
        title: "Speaker",
        description: "Storytellers and discourse hosts",
        icon: Icons.settings_voice_outlined,
      ),
      ServiceCategory(
        title: "Decor",
        description: "Stage, mandap and venue decoration",
        icon: Icons.museum_outlined, // Mandap like columns structure
      ),
      ServiceCategory(
        title: "Percussion",
        description: "Drum and rhythm ensembles",
        icon: Icons.music_note_outlined,
      ),
      ServiceCategory(
        title: "Host",
        description: "Ritual and ceremony specialists",
        icon: Icons.wb_sunny_outlined,
        isCustomDiya: true, // Will render DiyaWidget from login_screen
      ),
      ServiceCategory(
        title: "Catering",
        description: "Event meals and refreshments",
        icon: Icons.soup_kitchen_outlined,
      ),
    ];
  }
}
