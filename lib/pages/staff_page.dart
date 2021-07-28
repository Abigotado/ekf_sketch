import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekf_sketch/widgets/add_staff_button.dart';
import 'package:ekf_sketch/widgets/staff_data.dart';
import 'package:ekf_sketch/widgets/staff_data_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  List<StaffData> staff = [];

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    final productsRef = db.collection('staff');
    productsRef.get().then((serverProducts) {
      List<StaffData> preparedProducts = [];
      for (var product in serverProducts.docs) {
        final productsKidsRef = db.collection('staff/${product.id}/kids');
        productsKidsRef.get().then((kids) {
          StaffData prepareProduct = StaffData(
            surname: product.get('lastName'),
            name: product.get('firstName'),
            fatherName: product.get('patronimic'),
            dateOfBirth: product.get('birthDate'),
            position: product.get('positionHeld'),
            documentId: product.id,
            kidsAmount: kids.size,
          );
          preparedProducts.add(prepareProduct);
        });
      }
      setState(() {
        staff = preparedProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('staff').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return ListView.builder(
                      itemCount: staff.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return AddStaff();
                        }
                        int numberOfExtraWidget = 1;
                        index = index - numberOfExtraWidget;
                        return StaffDataItem(value: staff[index]);
                      });
              }),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Сотрудники'.toUpperCase()),
        backgroundColor: Color.fromRGBO(81, 140, 255, 1),
      ),
    );
  }
}
