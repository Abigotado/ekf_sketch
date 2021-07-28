import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekf_sketch/widgets/add_stuff_button.dart';
import 'package:ekf_sketch/widgets/stuff_data.dart';
import 'package:ekf_sketch/widgets/stuff_data_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StuffPage extends StatefulWidget {
  @override
  _StuffPageState createState() => _StuffPageState();
}

class _StuffPageState extends State<StuffPage> {
  List<StuffData> stuff = [];

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    final productsRef = db.collection('stuff');
    productsRef.get().then((serverProducts) {
      List<StuffData> preparedProducts = [];
      for (var product in serverProducts.docs) {
        final productsKidsRef = db.collection('stuff/${product.id}/kids');
        productsKidsRef.get().then((kids) {
          StuffData prepareProduct = StuffData(
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
        stuff = preparedProducts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('stuff').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return ListView.builder(
                      itemCount: stuff.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return AddStuff();
                        }
                        int numberOfExtraWidget = 1;
                        index = index - numberOfExtraWidget;
                        return StuffDataItem(value: stuff[index]);
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
