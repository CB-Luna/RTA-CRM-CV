import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  CarouselController buttonCarouselController = CarouselController();

  List<Map<String, String>> reviews = [
    {
      'text':
          'Great Experience working with this CRM.\nEasy and intuitive interface.',
      'image': 'assets/images/avatar.png',
    },
    {
      'text': 'Easy to use CRM',
      'image': 'assets/images/avatar2.png',
    },
    {
      'text': 'Great product. Would recommend!',
      'image': 'assets/images/avatar3.png',
    },
  ];

  int currentReview = 0;

  // void createTimer() {
  //   Timer.periodic(const Duration(seconds: 3), (timer) {
  //     currentReview += 1;
  //     if (currentReview == reviews.length) {
  //       currentReview = 0;
  //     }
  //     setState(() {});
  //   });
  // }

  // @override
  // void initState() {
  //   createTimer();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.zero,
          width: size.width,
          height: size.height * 0.202,
          child: SvgPicture.asset(
            'assets/images/bottom_svg.svg',
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 100,
          bottom: 50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  reviews.length,
                  (index) => GestureDetector(
                    onTap: () => buttonCarouselController.animateToPage(index),
                    child: Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentReview
                            ? AppTheme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: AppTheme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 90,
                width: 375,
                child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    height: 90,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (position, reason) {
                      currentReview = position;
                      setState(() {});
                    },
                    enableInfiniteScroll: false,
                  ),
                  itemCount: reviews.length,
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return ReviewElement(
                      text: reviews[itemIndex]['text'] ?? '',
                      image: reviews[itemIndex]['image'] ?? '',
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ReviewElement extends StatelessWidget {
  const ReviewElement({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
            width: 55,
            height: 65,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          overflow: TextOverflow.ellipsis,
          text,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
