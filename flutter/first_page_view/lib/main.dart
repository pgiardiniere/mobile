import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void main() {
  runApp(MaterialApp(
    title: 'first page view demo',
    // home: NoDependencies(),
    // home: WithPhotoView(),
    // home: WithPhotoViewGallery(),
    home: WithPhotoViewGalleryBuilder(),
  ));
}

// The PageView class is a scrollable list which works page by page.
// https://api.flutter.dev/flutter/widgets/PageView-class.html

// For Traffickcam, we need a pageview first and foremost to get gallery
// style image previews.

// Additionally, I've seen it said that a PageView/ListView combination
// can create a carousel like we need for the label previews.

class NoDependencies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = <Image>[];
    images.add(Image.asset('assets/images/img_1.jpg'));
    images.add(Image.asset('assets/images/img_2.jpg'));
    images.add(Image.asset('assets/images/img_3.jpg'));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        actions: <Widget>[
          IconButton(
            tooltip: 'Delete this image',
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              // delete the image
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: PageController(),
        itemCount: images.length,
        itemBuilder: (context, i) {
          return images[i];
        },
      ),
    );
  }
}

class WithPhotoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = <Image>[];
    images.add(Image.asset('assets/images/img_1.jpg'));
    images.add(Image.asset('assets/images/img_2.jpg'));
    images.add(Image.asset('assets/images/img_3.jpg'));

    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoView(
        imageProvider: images[0].image,
      ),
    );
  }
}

// Static constructor
class WithPhotoViewGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final images = <Image>[];
    images.add(Image.asset('assets/images/img_1.jpg'));
    images.add(Image.asset('assets/images/img_2.jpg'));
    images.add(Image.asset('assets/images/img_3.jpg'));

    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoViewGallery(
        pageOptions: <PhotoViewGalleryPageOptions>[
          PhotoViewGalleryPageOptions(imageProvider: images[0].image),
          PhotoViewGalleryPageOptions(imageProvider: images[1].image),
          PhotoViewGalleryPageOptions(imageProvider: images[2].image),
        ],
      ),
    );
  }
}

// Dynamic constructor, allows us to update list as we go.
// This is important as we want to delete images on the fly.

// Also see:
// https://resocoder.com/2019/05/04/flutter-photo-view-gallery-resize-rotate-image-carousel/
// Ctrl+f '.builder' to get to relevant sample.


// Important note: On tracking current index of page for the delete function:

// If you try to track index within the 'builder' context,
// You'll find that every time you traverse backwards in the list,
// the delete function will grab the highest index you accessed.
// This is because the builder only runs during list creation, as we expect.

// To keep track of your current index, use the 'onPageChanged' parameter.
// onPageChanged behaves exactly the same in PageView as in this dependency.

// Now if we update the 

class WithPhotoViewGalleryBuilder extends StatefulWidget {
  @override
  _WithPhotoViewGalleryBuilderState createState() => _WithPhotoViewGalleryBuilderState();
}

class _WithPhotoViewGalleryBuilderState extends State<WithPhotoViewGalleryBuilder> {
  // To do: in the main app, if the user deletes all photos (images is empty)
  // return them to the photo capture screen.
  var images = <Image>[];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    images.add(Image.asset('assets/images/img_1.jpg'));
    images.add(Image.asset('assets/images/img_2.jpg'));
    images.add(Image.asset('assets/images/img_3.jpg'));
  }

  void deletePhoto(int i) {
    images.removeAt(i);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, i) {
          return PhotoViewGalleryPageOptions(
            imageProvider: images[i].image,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 1.25,
          );
        },
        onPageChanged: (i) => _index = i,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        tooltip: "Delete This Image",
        child: Icon(Icons.delete, size: 30),
        onPressed: () {
          deletePhoto(_index);
        },
      ),
    );
  }
}
