import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:picoyplaca/widgets/list.dart';
import 'package:picoyplaca/widgets/search_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var placa;
  int placa_int = 0;
  bool _isExpanded = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      if (_controller.text.isEmpty) {
        _isExpanded = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade200,
        leading: LineIcon(LineIcons.search),
        title: Text('Consultar horarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            _titulo(),
            SizedBox(height: 50),
            _inputPlaca(),
            SizedBox(height: 25),
            _buttonSearch(),
            Divider(
              color: Colors.blue,
            ),
            _listHorario(),
            Visibility(
              visible: _isExpanded,
              child: Divider(
                color: Colors.blue,
              ),
            ),
            _infoMultas(),
          ],
        ),
      ),
    );
  }

  Card _infoMultas() {
    return Card(
        color: Colors.blue.shade100,
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text('Multas por infinfir la medida son:'),
              _lista('Primera vez', '63.75 dólares', ''),
              _lista('Segunda vez', '106.25 dólares', ''),
              _lista('Tercera vez', '212.50 dólares', ''),
            ],
          ),
        ));
  }

  Widget _lista(String title, String subtitle, String trailing) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.amber,
        child: LineIcon(LineIcons.dollarSign),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(trailing),
    );
  }

  Visibility _listHorario() {
    return Visibility(
      child: ListPicoPlaca(numPlaca: placa_int),
      visible: _isExpanded,
    );
  }

//Widgets
  Widget _titulo() {
    return Center(
        child: Text(
      'Ingresa la placa del vehículo',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ));
  }

  Widget _inputPlaca() {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.abc),
          hintText: 'AAC0123',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      controller: _controller,
      textCapitalization: TextCapitalization.characters,
      textAlign: TextAlign.center,
      maxLength: 7,
      //autofocus: true,
      onEditingComplete: () {
        _validatePlaca();
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  _validatePlaca() {
    if (_controller.text.isEmpty) {
      _message();
    } else {
      setState(() {
        //print('consultar: ${_controller.text}');
        //placa = _controller.text;
        placa = _controller.text.characters.last;
        try {
          placa_int = int.tryParse(placa)!;
          if (placa_int == null) {
            //print('Verifique la placa');
            _errorMessage();
          } else {
            //print('placa int: $placa_int');
            _isExpanded = true;
          }
        } catch (e) {
          print(e);
          _message();
        }

        //print('placa: $placa');
      });
    }
  }

  _message() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return _errorMessage();
        });
  }

  Widget _errorMessage() {
    return AlertDialog(
      title: Text('Información'),
      content: Text('¡Verifique el número de la placa!'),
      actions: [
        ButtonImageFb1(
            text: "Aceptar",
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  Widget _buttonSearch() {
    return Container(
        height: 50,
        child: ButtonImageFb1(
            text: 'Consultar',
            onPressed: () {
              _validatePlaca();
              FocusManager.instance.primaryFocus?.unfocus();
            }));
  }
}
