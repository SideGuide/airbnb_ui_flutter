import 'package:flutter/material.dart';
import '../models/place.dart';

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
