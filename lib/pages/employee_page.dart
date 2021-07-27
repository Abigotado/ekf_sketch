import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekf_sketch/widgets/date_validator.dart';
import 'package:ekf_sketch/widgets/kid_data_item.dart';
import 'package:ekf_sketch/widgets/kids_data.dart';
import 'package:ekf_sketch/widgets/name_validator.dart';
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

  var surnameKid = '';
  var nameKid = '';
  var fatherNameKid = '';
  var dateOfBirthKid = '';

  final _formKey = GlobalKey<FormState>();

  void sendContactInfo() async {
    db.collection('stuff/$id/kids').add({
      "lastName": surnameKid,
      "firstName": nameKid,
      "patronimic": fatherNameKid,
      "birthDate": dateOfBirthKid,
    }).then((value) {
      print(value.id);
    });
  }

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
                  child: Text(
                    'Должность:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(widget.value.position),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Дата рождения:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(widget.value.dateOfBirth),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Дети:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (_kids.isNotEmpty)
                  Container(
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
                                  return KidDataItem(value: _kids[index]);
                                });
                        }),
                  )
                else
                  Center(child: Text('Нет детей')),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                          builder: (BuildContext context) {
                             return Container(
                               height: 600,
                               color: Color.fromRGBO(81, 140, 255, 1),
                               child: Form(
                                 key: _formKey,
                                 child: Container(
                                   padding: EdgeInsets.only(top: 20),
                                   color: Color.fromRGBO(81, 140, 255, 1),
                                   child: Column(
                                     children: [
                                       Expanded(
                                           flex: 14,
                                           child: Container(
                                             padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                             child: SingleChildScrollView(
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Center(
                                                       child: Container(
                                                         margin: EdgeInsets.only(bottom: 10),
                                                         child: Text("Введите данные ребенка",
                                                             style: TextStyle(
                                                                 fontWeight: FontWeight.w500,
                                                                 fontSize: 24,
                                                                 color: Colors.white)),
                                                       )),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 5),
                                                     child: Text("Фамилия",
                                                         style: TextStyle(
                                                             fontWeight: FontWeight.w500,
                                                             fontSize: 16,
                                                             color: Colors.white)),
                                                   ),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 10),
                                                     child: TextFormField(
                                                       autovalidateMode: AutovalidateMode.always,
                                                       validator: nameValidator,
                                                       textCapitalization: TextCapitalization.words,
                                                       decoration: InputDecoration(
                                                         isDense: true,
                                                         contentPadding: EdgeInsets.all(10),
                                                         enabledBorder: OutlineInputBorder(
                                                             borderRadius: BorderRadius.circular(10),
                                                             borderSide:
                                                             BorderSide(color: Colors.transparent)),
                                                         filled: true,
                                                         fillColor: Colors.white,
                                                       ),
                                                       style: TextStyle(
                                                           fontSize: 14,
                                                           color: Color.fromRGBO(0, 17, 51, 0.6)),
                                                       onChanged: (value) {
                                                         setState(() {
                                                           surnameKid = value;
                                                         });
                                                       },
                                                     ),
                                                   ),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 5),
                                                     child: Text("Имя",
                                                         style: TextStyle(
                                                             fontWeight: FontWeight.w500,
                                                             fontSize: 16,
                                                             color: Colors.white)),
                                                   ),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 10),
                                                     child: TextFormField(
                                                       autovalidateMode: AutovalidateMode.always,
                                                       validator: nameValidator,
                                                       textCapitalization: TextCapitalization.words,
                                                       decoration: InputDecoration(
                                                         isDense: true,
                                                         contentPadding: EdgeInsets.all(10),
                                                         enabledBorder: OutlineInputBorder(
                                                             borderRadius: BorderRadius.circular(10),
                                                             borderSide:
                                                             BorderSide(color: Colors.transparent)),
                                                         filled: true,
                                                         fillColor: Colors.white,
                                                       ),
                                                       style: TextStyle(
                                                           fontSize: 14,
                                                           color: Color.fromRGBO(0, 17, 51, 0.6)),
                                                       onChanged: (value) {
                                                         setState(() {
                                                           nameKid = value;
                                                         });
                                                       },
                                                     ),
                                                   ),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 5),
                                                     child: Text("Отчество",
                                                         style: TextStyle(
                                                             fontWeight: FontWeight.w500,
                                                             fontSize: 16,
                                                             color: Colors.white)),
                                                   ),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 10),
                                                     child: TextFormField(
                                                       textCapitalization: TextCapitalization.words,
                                                       autovalidateMode: AutovalidateMode.always,
                                                       validator: nameValidator,
                                                       decoration: InputDecoration(
                                                         isDense: true,
                                                         contentPadding: EdgeInsets.all(10),
                                                         enabledBorder: OutlineInputBorder(
                                                             borderRadius: BorderRadius.circular(10),
                                                             borderSide:
                                                             BorderSide(color: Colors.transparent)),
                                                         filled: true,
                                                         fillColor: Colors.white,
                                                       ),
                                                       style: TextStyle(
                                                           fontSize: 14,
                                                           color: Color.fromRGBO(0, 17, 51, 0.6)),
                                                       onChanged: (value) {
                                                         setState(() {
                                                           fatherNameKid = value;
                                                         });
                                                       },
                                                     ),
                                                   ),
                                                   Container(
                                                     margin: EdgeInsets.only(bottom: 5),
                                                     child: Text("Дата рождения",
                                                         style: TextStyle(
                                                             fontWeight: FontWeight.w500,
                                                             fontSize: 16,
                                                             color: Colors.white)),
                                                   ),
                                                   Container(
                                                     child: TextFormField(
                                                       keyboardType: TextInputType.number,
                                                       textCapitalization: TextCapitalization.none,
                                                       autovalidateMode: AutovalidateMode.always,
                                                       validator: dateValidator,
                                                       decoration: InputDecoration(
                                                         isDense: true,
                                                         contentPadding: EdgeInsets.all(10),
                                                         enabledBorder: OutlineInputBorder(
                                                             borderRadius: BorderRadius.circular(10),
                                                             borderSide:
                                                             BorderSide(color: Colors.transparent)),
                                                         filled: true,
                                                         fillColor: Colors.white,
                                                       ),
                                                       style: TextStyle(
                                                           fontSize: 14,
                                                           color: Color.fromRGBO(0, 17, 51, 0.6)),
                                                       onChanged: (value) {
                                                         setState(() {
                                                           dateOfBirthKid = value;
                                                         });
                                                       },
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           )),
                                       Expanded(
                                         flex: 3,
                                         child: Container(
                                           margin: EdgeInsets.fromLTRB(20, 5, 20, 40),
                                           child: ElevatedButton(
                                             onPressed: () {
                                               if (_formKey.currentState!.validate()) {
                                                 sendContactInfo();
                                                 Navigator.pop(
                                                     context);
                                               }
                                             },
                                             style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(Colors.white)),
                                             child: Center(
                                                 child: Text("Отправить",
                                                     style: TextStyle(
                                                         fontWeight: FontWeight.w500,
                                                         fontSize: 16,
                                                         color: Color.fromRGBO(81, 140, 255, 1)))),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             );
                          });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(81, 140, 255, 1))),
                    child: Center(
                        child: Text("Добавить ребенка",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white))),
                  ),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
