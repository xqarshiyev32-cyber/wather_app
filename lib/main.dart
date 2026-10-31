import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherHomeScreen(),
    );
  }
}

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  // API kalitingizni shu yerga kiriting:
  final String apiKey = "8f1f295f288616da7c2cf3cede7e81d7";
  final String city = "Tashkent";

  String temp = "--";
  String weatherDescription = "Yuklanmoqda...";
  bool isLoading = false;

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          temp = data['main']['temp'].toStringAsFixed(1);
          weatherDescription = data['weather'][0]['description'];
          isLoading = false;
        });
      } else {
        setState(() {
          weatherDescription = "Xatolik: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        weatherDescription = "Tarmoq xatosi!";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$city Ob-havosi'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$temp °C',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    weatherDescription.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: fetchWeather,
                    child: const Text('Yangilash'),
                  ),
                ],
              ),
      ),
    );
  }
}