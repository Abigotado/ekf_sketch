import 'package:ekf_sketch/pages/employee_page.dart';
import 'package:ekf_sketch/widgets/staff_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffDataItem extends StatelessWidget {
  final StaffData value;

  StaffDataItem({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<StaffData>(
                builder: (context) => EmployeePage(value: value)));
      },
      child: Container(
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
                    value.surname,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 2),
                  child: Text(
                    value.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  child: Text(
                    value.fatherName,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                value.dateOfBirth,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                value.position,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                'Количество детей: ${value.kidsAmount}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
