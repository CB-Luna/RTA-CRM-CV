import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/login_page/widgets/custom_clipper.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  CarouselController carouselController = CarouselController();

  List<String> images = [
    'assets/images/background.png',
    'assets/images/background2.png',
    'assets/images/background3.png',
    'assets/images/background4.png',
  ];
  List<String> AssetsImages = [
    assets.background,
    assets.background2,
    assets.background3,
    assets.background4,
  ];

  int currentReview = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        ClipPath(
          clipper: ContainerClipper(),
          child: Container(
            width: size.width * 0.625,
            height: size.height,
            color: Colors.transparent,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, itemIndex, pageViewIndex) {
                return ImageElement(image: images[itemIndex]);
              },
              carouselController: carouselController,
              options: CarouselOptions(
                height: size.height,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (position, reason) {
                  currentReview = position;
                  setState(() {});
                },
                enableInfiniteScroll: false,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          right: 250,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: AssetsImages.isEmpty
                ? List.generate(
                    images.length,
                    (index) => GestureDetector(
                      onTap: () => carouselController.animateToPage(index),
                      child: Container(
                        height: 6.18,
                        width: 61.84,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: index == currentReview
                              ? AppTheme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  )
                : List.generate(
                    AssetsImages.length,
                    (index) => GestureDetector(
                      onTap: () => carouselController.animateToPage(index),
                      child: Container(
                        height: 6.18,
                        width: 61.84,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: index == currentReview
                              ? AppTheme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 310,
          right: 0,
          child: SizedBox(
            width: 650,
            height: 243.57,
            child: Text(
              'Rural\nTelecommunications of\nAmerica',
              maxLines: 3,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                shadows: [
                  const Shadow(
                    color: Color(0xFF345694),
                    blurRadius: 4,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ImageElement extends StatelessWidget {
  const ImageElement({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: BoxFit.cover,
      alignment: Alignment.centerLeft,
    );
  }
}
