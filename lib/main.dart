import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(
      const MyApp(), // Wrap your app
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbnb Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}

// ######## Pages ########

// pages/home_page.dart

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;

  /// _scrollListener() is a function that sets the state of the _scrollControllerOffset variable to the
  /// current offset of the scroll controller
  void _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  /// > The initState() function is called when the widget is first created
  @override
  void initState() {
    /// Creating a scroll controller and adding a listener to it.
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: const [
              HeroBanner(),
              Header("Explore Nearby"),
              CitiesGrid(),
              Header("Live Anywhere"),
              LiveAnywhereList(),
            ],
          ),
          FadeAppBar(scrollOffset: _scrollControllerOffset)
        ],
      ),
    );
  }
}

// ######## Widgets ########

// Widgets/City_widgets.dart

class CityCard extends StatelessWidget {
  final City city;

  const CityCard(this.city, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              city.image,
              width: 59,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(city.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(city.subtitle,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// `CitiesGrid` is a `StatelessWidget` that displays a `GridView` of `CityCard`s
class CitiesGrid extends StatelessWidget {
  const CitiesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 2.5 / 1,
          crossAxisCount: 2),

      /// A delegate that builds a list of children that are identified by
      /// index.
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CityCard(cities[index]);
        },
        childCount: cities.length,
      ),
    );
  }
}

// Widgets/Fade_app_bar.dart

class FadeAppBar extends StatelessWidget {
  final double scrollOffset;
  const FadeAppBar({Key? key, required this.scrollOffset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 24.0,
          ),
          color: Colors.white
              .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
          child: const SafeArea(child: SearchInput()),
        ));
  }
}

// Widgets/header.dart
class Header extends StatelessWidget {
  final String text;
  const Header(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.9)),
        ),
      ),
    );
  }
}

// Widgets/hero_banner.dart
class HeroBanner extends StatelessWidget {
  const HeroBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2.1,
        child: Stack(
          children: [
            Image.network(
              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Fairbnb_home.webp?alt=media&token=27e4e303-eac2-4144-945f-73769bcb81f7",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height / 2.1,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Text("Not sure where to go?\nPerfect.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5),
                        alignment: Alignment.center,
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                right: 50, left: 50, top: 12.5, bottom: 12.5)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor: MaterialStateProperty.resolveWith(
                          (states) {
                            return states.contains(MaterialState.pressed)
                                ? Colors.grey.shade100
                                : null;
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        )),
                    onPressed: () {},
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.purple, Colors.pink]).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: const Text(
                        "I'm flexible",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widgets/live_anywhere_widgets.dart
class LiveAnywhereList extends StatelessWidget {
  const LiveAnywhereList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 500,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: places.length,
          itemBuilder: (context, index) {
            return LiveAnywhereCard(places[index]);
          },
        ),
      ),
    );
  }
}

class LiveAnywhereCard extends StatelessWidget {
  final Place place;

  const LiveAnywhereCard(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                place.image,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(place.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.9))),
        ],
      ),
    );
  }
}

// Widgets/search_input.dart

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              spreadRadius: 0,
              color: Colors.grey.withOpacity(.1)),
        ]),
        child: TextField(
          controller: TextEditingController(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.email),
            prefixIcon:
                const Icon(Icons.search, size: 20, color: Color(0xffFF5A60)),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Where are you going?',
            hintStyle: TextStyle(color: Colors.black.withOpacity(.75)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ));
  }
}

// Widgets/sliver_delegate.dart

// 1
class SliverFixedDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverFixedDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(SliverFixedDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

// ######## Models ########

// models/city.dart

class City {
  String title;
  String subtitle;
  String image;

  City({required this.title, required this.subtitle, required this.image});
}

List<City> cities = [
  City(
      title: "Portland",
      image:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Fportland.png?alt=media&token=5679fa53-c854-4833-bfb2-799ad4b83f34",
      subtitle: "1.5 hour drive"),
  City(
      title: "Boston",
      image:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Fboston.png?alt=media&token=ddf740c9-0d85-4bd7-8cd3-3732029a3ea1",
      subtitle: "5 hour drive"),
  City(
      title: "Newark",
      image:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Fnewark.png?alt=media&token=f845d590-c831-4942-94d0-f2b13c11c339",
      subtitle: "3 hour drive"),
  City(
      title: "New York",
      image:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Fny.jpeg?alt=media&token=356763c5-18b1-4e22-96be-448756ae2b1c",
      subtitle: "8 hour drive"),
];

// models/place.dart
class Place {
  String title;
  String image;

  Place({required this.title, required this.image});
}

List<Place> places = [
  Place(
      title: "Outdoor Getaways",
      image:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Fnature.jpeg?alt=media&token=d0dda841-e419-4be0-aa0e-56dcdd42acfd"),
  Place(
      title: "Unique Stays",
      image:
          "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/airbnb%2Funique.jpeg?alt=media&token=669e01b2-64b9-47e5-a160-e1a8db1c1c7e"),
];
