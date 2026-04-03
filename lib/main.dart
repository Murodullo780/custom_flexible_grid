import 'package:custom_flexible_grid_package/custom_fl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Flexible Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> numbers = [];

  void makeNumbers() {
    for (int i = 0; i < 50; i++) {
      numbers.add(i);
    }
    for (int i = 50; i > 0; i--) {
      numbers.add(i);
    }
    setState(() {});
  }

  @override
  void initState() {
    makeNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Flexible Grid'),
        // title: const Text('Grid View Builder'),
      ),
      body: CustomFlexibleGrid(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        delegate: const CustomFlexibleGridDelegate(
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          crossAxisCount: 3,
        ),
        children: List.generate(numbers.length, (index) {
          return
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            height: (numbers[index] + 1) * 5,
            child: Center(
              child: Text(
                'Height: ${numbers[index] + 1} * 5',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
      ),
    );
  }
}
