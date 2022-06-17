import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PagePar extends StatefulWidget {
  PagePar({Key? key}) : super(key: key);

  @override
  State<PagePar> createState() => _PageParState();
}

class _PageParState extends State<PagePar> {
  List data = [];
  List items = [];
  Future<String> readJson() async {
    final String response = await rootBundle.loadString('assets/datos.json');
    setState((() => data = json.decode(response)["parqueaderos"]));
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
        title: Text('Parqueaderos de borde'),
        leading: LineIcon(LineIcons.parking),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var lugar = data[index]['lugar'];
                    var calle = data[index]['calle'];

                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            child: LineIcon(LineIcons.parking),
                          ),
                          title: Text(lugar),
                          subtitle: Text(
                            calle,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Divider(color: Colors.blue),
                      ],
                    );
                  }),
            ),
            Flexible(
              flex: 1,
              child: Card(
                elevation: 15,
                shadowColor: Colors.lightBlue,
                child: PhotoViewGallery.builder(
                  itemCount: 1,
                  //backgroundDecoration: ,
                  loadingBuilder: (context, event) => Center(
                      child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(),
                  )),
                  builder: (context, index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: AssetImage('assets/parq.jpg'),
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes: PhotoViewHeroAttributes(tag: 2),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
