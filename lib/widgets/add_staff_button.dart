import 'package:ekf_sketch/pages/add_employee_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStaff extends StatelessWidget {
  AddStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddEmployeePage()));
        },
        child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(81, 140, 255, 1)),
            child: Center(
              child: Text("Добавить сотрудника",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color.fromRGBO(255, 255, 255, 1))),
            )));
  }
}
