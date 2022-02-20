// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Skillbox 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text('\nSVG picture:\n'),
            SvgPicture.asset('assets/images/test.svg', height: 100,),
            const Text('\nImage from network:\n'),
            Image.network('https://picsum.photos/400/200'),
            const Text('\nCarouselSlider from git:\n'),
            CarouselSlider(
              options: CarouselOptions(height: 80.0),
              items: [1,2,3,4,5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: const BoxDecoration(
                            color: Colors.blue
                        ),
                        child: Text(
                            '\nText $i',
                            style: const TextStyle(fontSize: 20.0),
                            textAlign: TextAlign.center)
                    );
                  },
                );
              }).toList(),
            ),
            const Text('\n\n\nYou have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
