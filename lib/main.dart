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

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_3d/simple_3d.dart';
import 'package:util_simple_3d/util_sp3d_geometry.dart';
import 'package:util_simple_3d/f_sp3d_material.dart';
import 'package:simple_3d_renderer/sp3d_renderer.dart';
import 'package:simple_3d_renderer/sp3d_v2d.dart';
import 'package:simple_3d_renderer/sp3d_world.dart';
import 'package:simple_3d_renderer/sp3d_camera.dart';
import 'package:simple_3d_renderer/sp3d_light.dart';
import 'package:simple_3d_renderer/sp3d_faceobj.dart';

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
  ValueNotifier<int> vn = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    // Create Sp3dObj.

    // Sp3dObj tile = UtilSp3dGeometry.tile(200, 400, 34, 4);
    // this.objs.add(tile);

    Sp3dObj o1 = UtilSp3dGeometry.cone(7, 20);
    
    o1.rotate(Sp3dV3D(1,0,0).nor(), 270*3.14/180);
    o1.move(Sp3dV3D(0, 150, 100));
    this.objs.add(o1);

    Sp3dObj o2 = UtilSp3dGeometry.capsule(20, 50);
    o2.materials.add(FSp3dMaterial.redNonWire.deepCopy());
    // o2.materials.add(FSp3dMaterial.green.deepCopy());
    o2.move(Sp3dV3D(0, 150, 100));
    this.objs.add(o2);

    Sp3dObj obj = UtilSp3dGeometry.cube(200,200,200,4,4,4);
    // obj.materials.add(FSp3dMaterial.green.deepCopy());
    obj.materials.add(FSp3dMaterial.red.deepCopy()..strokeColor=Colors.black);
    obj.fragments[15].faces[2].materialIndex=1;

    int i =0;
    for(i=0; i<=15; i++){
      obj.fragments[i].faces[0].materialIndex=1;
    }

    obj.materials[1].imageIndex = 0;
    

    // obj.materials[0] = FSp3dMaterial.grey.deepCopy()..strokeColor=Colors.white;
    print("dadada ${obj.fragments[0].faces[0].vertexIndexList} llllll");
    
    // obj.rotate(Sp3dV3D(1,1,0).nor(), 30*3.14/180);
    // obj.move(Sp3dV3D(-200, 0, 0));
    this.objs.add(obj);
    loadImage();
  }

  void loadImage() async {

    this.objs[2].images.add(await _readFileBytes("./assets/images/sample_image.png"));

    this.world = Sp3dWorld(objs);
    this.world.initImages().then(
        (List<Sp3dObj> errorObjs){
          setState(() {
            this.isLoaded = true;
          });
        }
        );
  }

  Future<Uint8List> _readFileBytes(String filePath) async {
    ByteData bd = await rootBundle.load(filePath);
    return bd.buffer.asUint8List(bd.offsetInBytes,bd.lengthInBytes);
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
          body: Center(
            child: Container(
              color: Colors.blue.shade900,
              child: Sp3dRenderer(
                  k,
                  Size(600, 600),
                  Sp3dV2D(200, 300),
                  this.world,
                  // If you want to reduce distortion, shoot from a distance at high magnification.
                  Sp3dCamera(Sp3dV3D(0, 0, 100000), 60000),
                  Sp3dLight(Sp3dV3D(0, 0, -1), syncCam: true),
                //               allowFullCtrl: true,
                // allowUserWorldRotation: true,
                // checkTouchObj: true,
                // vn: this.vn,
                // onPanDownListener: (Offset offset, Sp3dFaceObj info){
                //   print("onPanDown");
                //   if(info!=null) {
                //     // info.obj.move(Sp3dV3D(50, 0, 0));
                //     // this.vn.value++;
                //   }
                // },
                // onPanCancelListener: (){
                //   print("onPanCancel");
                // },
                // onPanStartListener: (Offset offset){
                //   print("onPanStart");
                //   print(offset);
                // },
                // onPanUpdateListener: (Offset offset){
                //   print("onPanUpdate");
                //   print(offset);
                // },
                // onPanEndListener: (){
                //   print("onPanEnd");
                // },
              ),
            ),
          ),
        ),
      );
    }
  }
}
