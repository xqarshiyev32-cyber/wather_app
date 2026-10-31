import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WeatherHomeScreen(),
    );
  }
}

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String cityName = "Tashkent";
  String temperature = "24°C";
  String condition = "Quyoshli";

  void _searchWeather() {
    setState(() {
      cityName = _controller.text.isEmpty ? "Tashkent" : _controller.text;
      // Bu yerda API orqali real ma'lumot olish kodini ulashingiz mumkin
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather App'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.blue.shade800],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Shahar nomini kiriting...',
                hintStyle: const TextStyle(color: Colors.white70),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _searchWeather,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.yellow, width: 2),
                ),
              ),
            ),
            const Spacer(),
            Text(
              cityName,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              temperature,
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w300, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              condition,
              style: const TextStyle(fontSize: 24, color: Colors.white70),
            ),
            const Spacer(),
            const Text(
              'Created with Flutter 💙',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}