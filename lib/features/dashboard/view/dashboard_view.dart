import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int completedGoals = 3;
  int totalGoals = 7;
  int activeGoals = 4;

  void _incrementCompletedGoals() {
    setState(() {
      if (completedGoals < totalGoals) {
        completedGoals++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = completedGoals / totalGoals;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gösterge Paneli"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Başlık
            Text(
              'Dashboard View',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            // İstatistik Kartları
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard("Tamamlanan", completedGoals.toString(), Colors.green),
                _buildStatCard("Aktif", activeGoals.toString(), Colors.orange),
                _buildStatCard("Toplam", totalGoals.toString(), Colors.blue),
              ],
            ),
            const SizedBox(height: 30),

            // İlerleme Çubuğu
            Text("Genel İlerleme: ${(progress * 100).toStringAsFixed(1)}%"),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              color: Colors.green,
              backgroundColor: Colors.grey[300],
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 30),

            // Hedef Artırma Butonu
            ElevatedButton.icon(
              onPressed: _incrementCompletedGoals,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("Hedef Tamamla"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
