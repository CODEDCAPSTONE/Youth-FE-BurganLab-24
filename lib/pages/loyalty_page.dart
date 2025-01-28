import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/offer.dart';
import 'package:frontend/providers/extra_provider.dart';
import 'package:frontend/widgets/gift_drop.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoyaltyPage(),
    );
  }
}

class LoyaltyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GiftDropAnimation(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Loyalty',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: Color(0xFF0168aa),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Exclusive Offers',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Color(0xFF0168aa),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ExclusiveOffersSection(),
                      const SizedBox(height: 20),
                      const Text(
                        'Part-Time Job Offers',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: Color(0xFF0168aa),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      const PartTimeJobOffersSection(),
                      const SizedBox(height: 20),
                      // const Text(
                      //   'Upcoming Events',
                      //   style: TextStyle(
                      //     fontFamily: 'Inter',
                      //     fontWeight: FontWeight.w700,
                      //     fontSize: 28,
                      //     color: Color(0xFF0168aa),
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // UpcomingEventsSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExclusiveOffersSection extends StatefulWidget {
  final List<Map<String, String>> offers;

  const ExclusiveOffersSection({
    super.key,
    this.offers = const [
      {
        'imageUrl':
            'https://dashboard.codeparrot.ai/api/assets/Z44nn79JV5SvYOvf',
        'discount': '10% off',
      },
      {
        'imageUrl':
            'https://dashboard.codeparrot.ai/api/assets/Z44nn79JV5SvYOvg',
        'discount': '10% off',
      },
    ],
  });

  @override
  _ExclusiveOffersSectionState createState() => _ExclusiveOffersSectionState();
}

class _ExclusiveOffersSectionState extends State<ExclusiveOffersSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: FutureBuilder(
                future: context.read<ExtraProvider>().getOffers(),
                builder: (context, dataSnapshot) {
                  return Consumer<ExtraProvider>(
                      builder: (context, provider, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: provider.offers
                            .map((offer) => _buildOfferCard(offer))
                            .toList(),
                      ),
                    );
                  });
                }),
          ),
        );
      },
    );
  }

  Widget _buildOfferCard(Offer offer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: 254,
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              (offer.discount == 10)
                  ? 'assets/images/diet.jpeg'
                  : 'assets/images/oxygen.jpeg',
              width: 254,
              height: 128,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text(
                              'Offer claimed',
                              style: TextStyle(fontSize: 30),
                            ),
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.check_circle_outline,
                                    size: 100, color: Colors.green),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      // elevation: 12,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 15),
                                      backgroundColor:
                                          const Color.fromRGBO(1, 104, 170, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    child: const Text(
                                      "Dismiss",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              )
                            ],
                          );
                        });
                    // context.read<ExtraProvider>().offers.remove(offer);
                    // print(context.read<ExtraProvider>().offers.length);
                    // setState(() {});
                  },
                  child: const Text(
                    'Claim',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFBA6F),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "${offer.discount.toString()}% off",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PartTimeJobOffersSection extends StatelessWidget {
  const PartTimeJobOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<ExtraProvider>().getJobs(),
        builder: (context, dataSnapshot) {
          return Consumer<ExtraProvider>(builder: (context, provider, _) {
            return Container(
              height: 310,
              child: ListView.builder(
                  // shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.jobs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildJobCard(
                            index: index,
                            image: 'assets/images/mini_logo.png',
                            title: provider.jobs[index].titleJob,
                            details: provider.jobs[index].description,
                            context: context),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
            );
          });
        });
  }

  Widget _buildJobCard(
      {required int index,
      required String image,
      required String title,
      required String details,
      required BuildContext context}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (title.length > 20) ? title.substring(0, 20) : title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF242424),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                (details.length > 20) ? details.substring(0, 20) : details,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF707070),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push('/jobDetails', extra: index);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0168aa),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Read more',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingEventsSection extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      'title': 'Summer Music Festival',
      'date': 'July 15, 2023',
      'location': 'Central Park',
      'imageUrl': 'assets/images/mini_logo.png',
    },
    {
      'title': 'Tech Conference 2023',
      'date': 'August 5-7, 2023',
      'location': 'Convention Center',
      'imageUrl': 'assets/images/mini_logo.png',
    },
    {
      'title': 'Food & Drinks Expo',
      'date': 'September 10, 2023',
      'location': 'City Hall',
      'imageUrl': 'assets/images/mini_logo.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children:
            events.map((event) => AnimatedEventCard(event: event)).toList(),
      ),
    );
  }
}

class AnimatedEventCard extends StatefulWidget {
  final Map<String, String> event;

  const AnimatedEventCard({super.key, required this.event});

  @override
  _AnimatedEventCardState createState() => _AnimatedEventCardState();
}

class _AnimatedEventCardState extends State<AnimatedEventCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.asset(
                      widget.event['imageUrl']!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event['title']!,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0168aa),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.event['date']!,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          widget.event['location']!,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0168aa),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            'Learn More',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
