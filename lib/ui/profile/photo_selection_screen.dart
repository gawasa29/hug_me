import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants.dart';

class PhotoSelectionScreen extends ConsumerStatefulWidget {
  const PhotoSelectionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PhotoSelectionScreenState();
}

class _PhotoSelectionScreenState extends ConsumerState<PhotoSelectionScreen> {
  PageController controller = PageController(
    initialPage: 0,
  );
  var images = [
    "https://i.pinimg.com/originals/aa/eb/7f/aaeb7f3e5120d0a68f1b814a1af69539.png",
    "https://cdn.fnmnl.tv/wp-content/uploads/2020/09/04145716/Stussy-FA20-Lookbook-D1-Mens-12.jpg",
    "https://www.propermag.com/wp-content/uploads/2020/03/0x0-19.9.20_18908-683x1024.jpg",
    "http://www.thefashionisto.com/wp-content/uploads/2014/06/Marc-by-Marc-Jacobs-Men-2015-Spring-Summer-Collection-Look-Book-001.jpg",
    "https://im0-tub-ru.yandex.net/i?id=e2e0f873e86f34e5001ddc59b42e23a6-l&ref=rim&n=13&w=828&h=828",
    "https://www.thefashionisto.com/wp-content/uploads/2013/07/w012-800x1200.jpg",
    "https://manofmany.com/wp-content/uploads/2016/09/14374499_338627393149784_1311139926468722688_n.jpg",
    "https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2020%2F04%2Faries-fall-winter-2020-lookbook-first-look-14.jpg?q=75&w=800&cbr=1&fit=max",
    "https://i.pinimg.com/originals/95/0f/4d/950f4df946e0a373e47df37fb07ea1f9.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new,
                  color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Column(
          children: <Widget>[
            const Text(
              '写真の追加',
              style: TextStyle(
                fontSize: 24,
                color: Color.fromARGB(255, 83, 83, 83),
              ),
            ),
            Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: PageView.builder(
                      itemBuilder: (BuildContext context, int index) =>
                          _buildImage(index),
                      itemCount: images.length,
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    child: SmoothPageIndicator(
                      controller: controller, // PageController
                      count: images.length,
                      effect: SlideEffect(
                          spacing: 4.0,
                          radius: 4.0,
                          dotWidth: (MediaQuery.of(context).size.width /
                                  images.length) -
                              4,
                          dotHeight: 4.0,
                          paintStyle: PaintingStyle.fill,
                          dotColor: Colors.grey,
                          activeDotColor:
                              Colors.white), // your preferred effect
                    ),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(
                  right: 40.0, left: 40.0, bottom: 40, top: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 97, 201, 196),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: const BorderSide(color: Color(mainColor))),
                  ),
                  child: const Text(
                    '写真を追加',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFAFAFA),
                    ),
                  ),
                  onPressed: () async {},
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildImage(int index) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: images[index],
      //👇はエラーの時の処理なのであんま関係ない
      placeholder: (context, imageUrl) {
        return const Icon(
          Icons.hourglass_empty,
          size: 75,
          color: Colors.white,
        );
      },
      errorWidget: (context, imageUrl, error) {
        return const Icon(
          Icons.error_outline,
          size: 75,
          color: Colors.white,
        );
      },
    );
  }
}
