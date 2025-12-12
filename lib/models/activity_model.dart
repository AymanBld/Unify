import 'package:flutter/material.dart';

class ActivityModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int impactScore; // How much it improves the score

  ActivityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.impactScore,
  });
}
