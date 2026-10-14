// ── Simple data model ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class ActivityRecord {
  final String typeName;
  final IconData icon;
  final double distanceKm;
  final int durationMin;
  final int calories;
  final String location;

  const ActivityRecord({
    required this.typeName,
    required this.icon,
    required this.distanceKm,
    required this.durationMin,
    required this.calories,
    required this.location,
  });
}
