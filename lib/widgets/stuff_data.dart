import 'package:ekf_sketch/widgets/kids_data.dart';
import 'package:flutter/cupertino.dart';

class StuffData {
  String documentId;
  String surname;
  String name;
  String fatherName;
  String dateOfBirth;
  String position;
  int kidsAmount;

  StuffData({
    required this.documentId,
    required this.surname,
    required this.name,
    required this.fatherName,
    required this.dateOfBirth,
    required this.position,
    required this.kidsAmount,
  });
}
