// import 'package:flutter/material.dart';
// import 'package:flutter_3d/home_page.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter 3D',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:util_simple_3d/util_sp3d_geometry.dart';
import 'package:util_simple_3d/f_sp3d_material.dart';
import 'package:simple_3d_renderer/sp3d_renderer.dart';
import 'package:simple_3d_renderer/sp3d_v2d.dart';
import 'package:simple_3d_renderer/sp3d_world.dart';
import 'package:simple_3d_renderer/sp3d_camera.dart';
import 'package:simple_3d_renderer/sp3d_light.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final k = GlobalKey();
  List<Sp3dObj> objs = [];
  Sp3dWorld world;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Create Sp3dObj.

    Sp3dObj o1 = UtilSp3dGeometry.cone(7, 20);
    o1.rotate(Sp3dV3D(1,0,0).nor(), 270*3.14/180);
    o1.move(Sp3dV3D(-200, 150, 100));
    this.objs.add(o1);

    Sp3dObj o2 = UtilSp3dGeometry.capsule(20, 50);
    // o2.materials.add(FSp3dMaterial.green.deepCopy());
    o2.move(Sp3dV3D(-200, 150, 100));
    this.objs.add(o2);

    Sp3dObj obj = UtilSp3dGeometry.cube(200,200,200,4,4,4);
    obj.materials.add(FSp3dMaterial.grey.deepCopy());
    obj.fragments[0].faces[0].materialIndex=1;
    obj.materials[0] = FSp3dMaterial.grey.deepCopy()..strokeColor=Colors.white;
    // obj.rotate(Sp3dV3D(1,1,0).nor(), 30*3.14/180);
    obj.move(Sp3dV3D(-200, 0, 0));
    this.objs.add(obj);
    loadImage();
  }

  void loadImage() async {
    this.world = Sp3dWorld(objs);
    this.world.initImages().then(
        (List<Sp3dObj> errorObjs){
          setState(() {
            this.isLoaded = true;
          });
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    if (!this.isLoaded) {
      return MaterialApp(
          title: 'Sp3dRenderer',
          home: Scaffold(
              appBar: AppBar(
                title: Text("aaaa"),
                backgroundColor: Color.fromARGB(255, 0, 255, 0),
              ),
              backgroundColor: Color.fromARGB(255, 33, 33, 33),
              body: Container()
          )
      );
    }
    else {
      return MaterialApp(
        title: 'Sp3dRenderer',
        home: Scaffold(
          appBar: AppBar(
            title: Text("3d test"),
            backgroundColor: Color.fromARGB(255, 0, 255, 0),
          ),
          backgroundColor: Color.fromARGB(255, 33, 33, 33),
          body: Column(
            children: [
              Sp3dRenderer(
                  k,
                  Size(700, 700),
                  Sp3dV2D(300, 400),
                  this.world,
                  // If you want to reduce distortion, shoot from a distance at high magnification.
                  Sp3dCamera(Sp3dV3D(0, 0, 100000), 60000),
                  Sp3dLight(Sp3dV3D(0, 0, -1), syncCam: true)
              )
            ],
          ),
        ),
      );
    }
  }
}
