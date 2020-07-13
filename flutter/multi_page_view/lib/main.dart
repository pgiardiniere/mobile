import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Multi-page-view carousels',
    // home: Demo1(),
    home: Demo2(),
  ));
}

// No infinite scroll.
class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var controller = PageController(viewportFraction: 1/5);
    final images = <Image>[];
    images.add(Image.asset('assets/images/img_1.jpg'));
    images.add(Image.asset('assets/images/img_2.jpg'));
    images.add(Image.asset('assets/images/img_3.jpg'));

    return PageView(
      children: images,
      controller: PageController(
        viewportFraction: 1 / 3,
        initialPage: 1,
      ),
    );
  }
}

// Infinite scroll using a PageView.builder & initialPage hack.
class Demo2 extends StatelessWidget {
  // This method overlays a transparent image on top of a colored container.
  _buildCarouselItem(String assetFilepath, double itemWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(itemWidth / 2),
      child: OverflowBox(
        alignment: Alignment.center,
        child: Container(
          height: itemWidth,
          width: itemWidth,
          color: Color.fromRGBO(127, 0, 127, 0.5),
          child: Image.asset('assets/images/transparent_reticle.png',
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  // This method overlays a transparent colored container on top of an image.
  // ** IF GET transparent photos, defer to the prior _buildCarouselItem method.
  _buildCarouselItem2(String assetFilepath, double itemWidth) {
    final radius = itemWidth / 2;
    return Padding(
      padding: EdgeInsets.all(itemWidth * 0.05),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          children: <Widget>[
            Container(
              height: itemWidth,
              width: itemWidth,
              color: Color.fromARGB(128, 128, 128, 128),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(radius / 3.14159),
                child: Image.asset(
                  assetFilepath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roundThumbnails = <Widget>[];
    final _itemWidth = MediaQuery.of(context).size.width / 5;

    roundThumbnails.addAll([
      _buildCarouselItem2('assets/images/img_artwork.png', _itemWidth),
      _buildCarouselItem2('assets/images/img_bed.png', _itemWidth),
      _buildCarouselItem2('assets/images/img_chair.png', _itemWidth),
      _buildCarouselItem2('assets/images/img_couch.png', _itemWidth),
      _buildCarouselItem2('assets/images/img_desk.png', _itemWidth),
      _buildCarouselItem2('assets/images/img_lamp.png', _itemWidth),
      _buildCarouselItem2('assets/images/img_toilet.png', _itemWidth),
    ]);

    return Scaffold(
      appBar: AppBar(title: Text('demo')),
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset('assets/images/img_3.jpg'),
          SizedBox(
            height: _itemWidth,
            child: PageView(
              controller: PageController(
                viewportFraction: 1 / 5,
                initialPage: 3,
              ),
              children: roundThumbnails,
            ),
          ),
          RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(width: _itemWidth * .025, color: Colors.white),
            ),
            elevation: 2.0,
            child: SizedBox(height: _itemWidth, width: _itemWidth),
            onPressed: () {
              // DoStuff
            },
          ),
        ],
      ),
    );
  }
}
