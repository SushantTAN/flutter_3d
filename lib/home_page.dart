import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_3d/panorama_example.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Object jet;
  Object shark;
  @override
  void initState() {
    jet = Object(fileName: "assets/jet/Jet.obj");
    shark = Object(fileName: "assets/shark/shark.obj");
    shark.rotation.setValues(0, 90, 0);
    shark.updateTransform();

    jet.rotation.setValues(0, 90, 0);
    // jet.position.setValues(0.1, 0.1, 0.2);
    // jet.scale.setValues(2, 2, 2);
    // jet.scale.splat(1.5);

    jet.updateTransform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Flutter 3D"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 10, 0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Panoramic();
                }));
              },
              child: Text("panorama"),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          children: [
            Expanded(
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(shark);
                  scene.camera.zoom = 10;
                },
              ),
            ),
            Expanded(
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(jet);
                  scene.camera.zoom = 10;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
