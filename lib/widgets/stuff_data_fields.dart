import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekf_sketch/pages/stuff_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'date_validator.dart';
import 'name_validator.dart';

class StuffDataFields extends StatefulWidget {
  StuffDataFields({Key? key}) : super(key: key);

  @override
  _StuffDataFieldsState createState() => _StuffDataFieldsState();
}

class _StuffDataFieldsState extends State<StuffDataFields> {
  var surname = '';
  var name = '';
  var fatherName = '';
  var dateOfBirth = '';
  var position = '';

  final _formKey = GlobalKey<FormState>();

  final firestoreInstance = FirebaseFirestore.instance;

  void sendContactInfo() async {
    firestoreInstance.collection('stuff').add({
      "lastName": surname,
      "firstName": name,
      "patronimic": fatherName,
      "birthDate": dateOfBirth,
      "positionHeld": position,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                          child: Text("Введите данные",
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
                                surname = value;
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
                                name = value;
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
                                fatherName = value;
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
                                dateOfBirth = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Text("Должность",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white)),
                        ),
                        Container(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
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
                                position = value;
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StuffPage()),
                      ).then((value) => setState(() {}));
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
    );
  }
}
