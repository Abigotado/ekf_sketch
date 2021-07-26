import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kids_data.dart';

class KidDataItem extends StatelessWidget {
  final KidsData value;

  KidDataItem({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(81, 140, 255, 1)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 2),
                child: Text(
                  value.kidSurname,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 2),
                child: Text(
                  value.kidName,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                child: Text(
                  value.kidFatherName,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
              value.kidDateOfBirth,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}