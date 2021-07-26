import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekf_sketch/widgets/kid_data_item.dart';
import 'package:ekf_sketch/widgets/kids_data.dart';
import 'package:ekf_sketch/widgets/stuff_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeePage extends StatefulWidget {
  final StuffData value;

  EmployeePage({Key? key, required this.value}) : super(key: key);

  @override
  _EmployeePageState createState() => _EmployeePageState(id: value.documentId);
}

class _EmployeePageState extends State<EmployeePage> {
  String id;
  _EmployeePageState({required this.id});

  List<KidsData> _kids = [];

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    final productsRef = db.collection('stuff/$id/kids');
    productsRef.get().then((serverProducts) {
      List<KidsData> preparedProducts = [];
      for (var product in serverProducts.docs) {
        KidsData prepareProduct = KidsData(
            kidSurname: product.get('lastName'),
            kidName: product.get('firstName'),
            kidFatherName: product.get('patronimic'),
            kidDateOfBirth: product.get('birthDate'));
        preparedProducts.add(prepareProduct);
        print(33333);
        print(product.get('lastName'));
        print(product.get('firstName'));
        print(product.get('patronimic'));
        print(product.get('birthDate'));
      }
      setState(() {
        _kids = preparedProducts;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text('Должность:',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  child: Text(widget.value.position),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text('Дата рождения:',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                  child: Text(widget.value.dateOfBirth),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Дети:', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Container(
                    color: Color.fromRGBO(81, 140, 255, 1),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: db.collection('stuff/$id/kids').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          else
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _kids.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (_kids.isNotEmpty)
                                    return KidDataItem(value: _kids[index]);
                                  else
                                    return Container(
                                        margin: EdgeInsets.all(15),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                15),
                                            color: Color.fromRGBO(
                                                81, 140, 255, 1)),
                                        child: Text('Нет детей', style: TextStyle(color: Colors.white),)
                                    );
                                });
                        }),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(right: 56),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(text: widget.value.name),
                  TextSpan(text: ' '),
                  TextSpan(text: widget.value.fatherName),
                  TextSpan(text: ' '),
                  TextSpan(text: widget.value.surname),
                ],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              maxLines: 2,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(81, 140, 255, 1),
      ),
    );
  }
}