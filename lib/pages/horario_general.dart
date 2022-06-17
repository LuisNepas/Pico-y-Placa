import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class PageHorario extends StatefulWidget {
  PageHorario({Key? key}) : super(key: key);

  @override
  State<PageHorario> createState() => _PageHorarioState();
}

class _PageHorarioState extends State<PageHorario> {
  List data = [];
  Future<String> readJson() async {
    final String response = await rootBundle.loadString('assets/datos.json');
    setState((() => data = json.decode(response)["horario"]));
    return 'suces';
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    this.readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        title: Text('Horario en General'),
        leading: LineIcon(LineIcons.calendarCheck),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Card(
          elevation: 15,
          shadowColor: Colors.lightBlue,
          color: Colors.lightBlue.shade50,
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var dia = data[index]['dia'];
                      var placa = data[index]['placa'];

                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              child: LineIcon(LineIcons.calendarCheckAlt),
                            ),
                            title: Text(dia),
                            subtitle: Text(
                              placa,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Divider(color: Colors.blue),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
