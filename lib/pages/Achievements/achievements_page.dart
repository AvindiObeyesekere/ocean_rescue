import 'package:flutter/material.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/logo/logo_without_name.png',
            fit: BoxFit.contain,
            width: 30,
            height: 30,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Color(0xFF1877F2),
            ),
            tooltip: 'Search',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.message,
              color: Color(0xFF1877F2),
            ),
            tooltip: 'Message',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                SizedBox(width: 20),
                Text(
                  'Achievements',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.emoji_events, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Achievements',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  achievementCard(
                    'Sea Cleaner',
                    'assets/medals/bronze.png',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  achievementCard(
                    'High Earner',
                    'assets/medals/bronze.png',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                  achievementCard(
                    'CleanStar',
                    'assets/medals/bronze.png',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget achievementCard(String title, String iconPath, String description) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.asset(
          iconPath,
          width: 50,
          height: 50,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1877F2),
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ),
    );
  }
}
