import 'package:flutter/material.dart';

void main() {
  runApp(EventApp());
}

class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: EventListScreen(),
    );
  }
}

class EventListScreenOld extends StatefulWidget {
  const EventListScreenOld({super.key});

  @override
  _EventListScreenOldState createState() => _EventListScreenOldState();
}

class _EventListScreenOldState extends State<EventListScreenOld> {
  bool isDarkMode = false;

  final List<Map<String, String>> events = [
    {
      'title': 'Tech Conference',
      'date': 'March 10, 2025',
      'image': 'https://source.unsplash.com/400x300/?conference'
    },
    {
      'title': 'Music Festival',
      'date': 'April 5, 2025',
      'image': 'https://source.unsplash.com/400x300/?music'
    },
    {
      'title': 'Startup Meetup',
      'date': 'May 20, 2025',
      'image': 'https://source.unsplash.com/400x300/?startup'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(events[index]['image']!,
                      height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
                ListTile(
                  title: Text(events[index]['title']!,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Text(events[index]['date']!),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventDetailScreen(event: events[index]),
                        ),
                      );
                    },
                    child: const Text('View'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Booked"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event['title']!)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(event['image']!,
                  height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),
            Text(event['title']!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Date: ${event['date']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Ticket booked successfully!'),
                  ));
                },
                child: const Text('Book Ticket'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: Text(
          'User Profile',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class BookedEventsScreen extends StatelessWidget {
  const BookedEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booked Events')),
      body: const Center(
        child: Text(
          'No booked events yet!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  int _selectedIndex = 0;
  bool isDarkMode = false;

  final List<Map<String, String>> events = [
    {
      'title': 'Tech Conference',
      'date': 'March 10, 2025',
      'image': 'https://source.unsplash.com/400x300/?conference'
    },
    {
      'title': 'Music Festival',
      'date': 'April 5, 2025',
      'image': 'https://source.unsplash.com/400x300/?music'
    },
    {
      'title': 'Startup Meetup',
      'date': 'May 20, 2025',
      'image': 'https://source.unsplash.com/400x300/?startup'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      _buildEventList(),
      BookedEventsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Booked"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(events[index]['image']!,
                    height: 150, width: double.infinity, fit: BoxFit.cover),
              ),
              ListTile(
                title: Text(events[index]['title']!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(events[index]['date']!),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventDetailScreen(event: events[index]),
                      ),
                    );
                  },
                  child: const Text('View'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}