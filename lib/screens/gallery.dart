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
    print("imageListSize... ${widget.imagesList}");
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
                    print('hey${index}');
                    // print('hey${widget.imagesList[1]}');
                    // print('hey${widget.imagesList[2]}');
                    // print('hey${widget.imagesList[3]}');
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child:
                          Image(image: NetworkImage(widget.imagesList[index])),
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: NetworkImage(widget.imagesList[index]),
                      //   ),
                      // )
                    );
                  }),
              // child: CarouselSlider(
              //   items: [

              //   ],
              //   options: CarouselOptions(
              //     height: 300.0,
              //     enlargeCenterPage: true,
              //     autoPlay: false,
              //     aspectRatio: 16 / 9,
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enableInfiniteScroll: true,
              //     // autoPlayAnimationDuration: Duration(milliseconds: 800),
              //     viewportFraction: 1,
              //   ),
              // )
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
