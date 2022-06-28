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
