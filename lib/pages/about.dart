import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
//import 'package:link/link.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class PageAbout extends StatefulWidget {
  PageAbout({Key? key}) : super(key: key);

  @override
  State<PageAbout> createState() => _PageAboutState();
}

class _PageAboutState extends State<PageAbout> {
  List data = [];
  List items = [];
  Future<String> readJson() async {
    final String response = await rootBundle.loadString('assets/datos.json');
    setState((() => data = json.decode(response)["informacion"]));
    // final data1 = await json.decode(response);
    // setState(() {
    //   items = data1["limites"];
    // });
    return 'suces';
  }

  @override
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
        title: Text('Información'),
        leading: LineIcon(LineIcons.parking),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Text(
              'La información proviene de las siguientes fuentes oficiales:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 25),
            Flexible(
              flex: 5,
              child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var titulo = data[index]['titulo'];
                    var cita = data[index]['cita'];

                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: LineIcon(LineIcons.bookReader),
                          ),
                          title: Text(titulo),
                          subtitle: Text(
                            cita,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(color: Colors.blue),
                      ],
                    );
                  }),
            ),
            Divider(
              color: Colors.blue,
            ),
            Flexible(
                flex: 1,
                child: Text(
                  'Links de interés:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Flexible(
                flex: 1,
                child: TextButton(
                  child: Text('Quito Informa'),
                  onPressed: () async {
                    const url =
                        'http://www.quitoinforma.gob.ec/tag/pico-y-placa/';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launch(url);
                    } else {
                      throw 'error $url';
                    }
                  },
                )),
            Flexible(
                child: TextButton(
              child: Text('El Universo'),
              onPressed: () async {
                const url =
                    'https://www.eluniverso.com/noticias/ecuador/los-horarios-y-placas-del-pico-y-placa-en-quito-para-este-1-de-junio-de-2022-carro-vehiculo-restriccion-movilidad-trafico-nota/';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launch(url);
                } else {
                  throw 'error $url';
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  void _launcherUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'error $url';
  }
}
