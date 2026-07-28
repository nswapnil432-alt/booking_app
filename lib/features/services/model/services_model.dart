import 'package:flutter/material.dart';

class ServiceCategory {
  final String title;
  final String description;
  final IconData icon;
  final bool isCustomDiya; // To identify if we need to show the custom DiyaWidget (Host category)

  ServiceCategory({
    required this.title,
    required this.description,
    required this.icon,
    this.isCustomDiya = false,
  });
}
