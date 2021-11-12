import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Panoramic"),
      ),
      body: Center(child: 
        Stack(
          // http://apps.laticrete.me/media/static/p_3_revise.png
          children: <Widget>[
            Container(
             decoration: BoxDecoration(color: Colors.amberAccent),
           ),
            Panorama( 
            animSpeed: 0.0,
            child: Image.network('https://l13.alamy.com/360/2BWEJ0M/full-spherical-seamless-hdri-panorama-360-degrees-in-the-yard-near-orthodox-church-in-equirectangular-projection-with-zenith-and-nadir-vr-content-2BWEJ0M.jpg'),
            // child: Image.asset('assets/images/PANO_20211104_183314.jpg'),
           ),
           
           ],
        )
      ),
    );
  }
}
