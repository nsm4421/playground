import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Carousel Demo",
      home: const CarouselExample()
    );
  }
}

class CarouselExample extends StatefulWidget {
  const CarouselExample({Key? key}) : super(key: key);

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {

  final List<String> _imgSrcList = [
    "assets/렌고쿠.jpg", "assets/무이치로.png", "assets/탄지로.jpg", "assets/텐겐.jpg"
  ];

  Widget CarouselWidget(){
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: _imgSrcList.map((src) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(src),
                )
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carousel Example"),
      ),
      body: Center(child: CarouselWidget()),
    );
  }
}
