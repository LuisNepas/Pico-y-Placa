import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class ListPicoPlaca extends StatefulWidget {
  late int numPlaca;
  ListPicoPlaca({Key? key, required this.numPlaca}) : super(key: key);

  @override
  State<ListPicoPlaca> createState() => _ListPicoPlacaState();
}

class _ListPicoPlacaState extends State<ListPicoPlaca> {
  String dia = '';
  String horario = 'De 06:00 hasta 09:30 y de 16:00 a 21:00';
  @override
  Widget build(BuildContext context) {
    int placa = this.widget.numPlaca;
    if (placa == 1 || placa == 2) {
      dia = 'Lunes';
    } else if (placa == 3 || placa == 4) {
      dia = 'Martes';
    } else if (placa == 5 || placa == 6) {
      dia = 'Miercoles';
    } else if (placa == 7 || placa == 8) {
      dia = 'Jueves';
    } else if (placa == 9 || placa == 0) {
      dia = 'Viernes';
    } else {
      dia = 'Sabados y Domingos';
    }
    return Card(
      elevation: 15,
      color: Colors.blue.shade100,
      child: Column(
        children: [
          Text(
            'Su vehiculo puede circular todos los días a exepción del $dia  en el siguiente horario:',
            style: _styleText(),
          ),
          SizedBox(height: 25),
          ListTile(
            leading: LineIcon(LineIcons.calendarWithWeekFocus),
            title: Text('Horario de restricción - $dia'),
            subtitle: Text(horario),
          ),
        ],
      ),
    );
  }

  _styleText() {
    TextStyle(fontWeight: FontWeight.bold);
  }
}
