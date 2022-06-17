import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:picoyplaca/pages/about.dart';
import 'package:picoyplaca/pages/horario_general.dart';
import 'package:picoyplaca/pages/limites.dart';
import 'package:picoyplaca/pages/parqueaderos.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'home_page.dart';

class BottomBarPage extends StatefulWidget {
  BottomBarPage({Key? key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  bool isHome = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int pageIndex = 0;
  final pages = [
    HomePage(),
    PageLimit(),
    PagePar(),
    PageHorario(),
    PageAbout(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      floatingActionButton: Visibility(
        visible: pageIndex == 0 ? false : true,
        child: FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            child: Icon(Icons.search_sharp)),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: pageIndex,
        onTap: (i) => setState(() => pageIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: LineIcon(LineIcons.search),
            title: Text("Consultar"),
            selectedColor: Colors.blue,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: LineIcon(LineIcons.road),
            title: Text("Límites"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: LineIcon(LineIcons.parking),
            title: Text("Parqueaderos"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: LineIcon(LineIcons.calendarWithDayFocus),
            title: Text("Horario"),
            selectedColor: Colors.teal,
          ),

          //about page
          SalomonBottomBarItem(
            icon: LineIcon(LineIcons.info),
            title: Text("Acerca de"),
            selectedColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
