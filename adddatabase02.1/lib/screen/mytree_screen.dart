import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/structure/plant.dart';
import 'package:app/main.dart';
import 'package:app/screen/sugges_screen.dart';
import 'package:app/structure/background_container.dart'; // ✅ เพิ่ม background

class PlantPage extends StatefulWidget {
  final Plant plant;

  const PlantPage({Key? key, required this.plant}) : super(key: key);

  @override
  _PlantPageState createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  double temperature = 30.0;
  int humidity = 53;
  int soilMoisture = 40;

  @override
  void initState() {
    super.initState();
  }

  String getSoilMoistureImage(int moisture) {
    if (moisture <= 0) return 'assets/0.PNG';
    if (moisture <= 25) return 'assets/25.PNG';
    if (moisture <= 50) return 'assets/50.PNG';
    if (moisture <= 75) return 'assets/75.PNG';
    return 'assets/100.PNG';
  }

  String getTreeImage(String type) {
    switch (type) {
      case 'เดซี่':
        return 'assets/daisy.png';
      case 'กุหลาบ':
        return 'assets/rose.PNG';
      case 'กล้วยไม้':
        return 'assets/ochid.png';
      case 'กะเพรา':
        return 'assets/basil.png';
      case 'พลูด่าง':
        return 'assets/pothos.png';
      case 'กระบองเพชร':
        return 'assets/cac.png';
      default:
        return 'assets/tree.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ เพื่อโชว์พื้นหลัง
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFFA7E584),
          onTap: (index) {
            if (index == 0) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SuggestPage(transaction: widget.plant),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: ''),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: const Color(0xFFA7E584),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.plant.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA7E584),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("Day 1", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: widget.plant.color,
                ),
                child: Column(
                  children: [
                    Image.asset(getTreeImage(widget.plant.type), height: 150),
                    const SizedBox(height: 10),
                    buildInfoRow("Name :", widget.plant.name),
                    buildInfoRow("ชนิด :", widget.plant.type),
                    buildInfoRow(
                      "DD/MM/YY :",
                      "${widget.plant.date.day}/${widget.plant.date.month}/${widget.plant.date.year}",
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Image.asset(getSoilMoistureImage(soilMoisture), height: 100),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Temperature", style: TextStyle(fontSize: 16)),
                          Text("Humidity", style: TextStyle(fontSize: 16)),
                          Text("Soil Moisture", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${temperature.toStringAsFixed(1)} °C",
                              style: const TextStyle(fontSize: 16)),
                          Text("$humidity%", style: const TextStyle(fontSize: 16)),
                          Text("$soilMoisture%", style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }
}
