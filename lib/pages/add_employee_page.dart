import 'package:ekf_sketch/widgets/stuff_data_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEmployeePage extends StatefulWidget {
  AddEmployeePage({Key? key, value}) : super(key: key);

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: StuffDataFields(),
      ),
      appBar: AppBar(
        title: Text("Добавить сотрудника".toUpperCase()),
        elevation: 0,
        backgroundColor: Color.fromRGBO(81, 140, 255, 1),
        centerTitle: true,
      ),
    );
  }
}