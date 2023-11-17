import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Galleryimage extends StatefulWidget {
  @override
  String imageLink = "";
  List<String> imagesList;
  Galleryimage(this.imagesList);
  _GalleryimageState createState() => _GalleryimageState();
}

class _GalleryimageState extends State<Galleryimage> {
  get flase => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Center(
            child: Hero(
              tag: "item",
              child: PageView.builder(
                  itemCount: widget.imagesList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child:
                          Image(image: NetworkImage(widget.imagesList[index])),
                    );
                  }),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              child: new IconButton(
                  icon: new Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 32,
                  ),
                  color: Color(0xFF203040),
                  onPressed: () => {Navigator.pop(context)}),
            ),
          ),
        ],
      )),
    );
  }
}
