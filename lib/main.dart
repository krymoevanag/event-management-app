import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const EventApp());
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class EventApp extends StatefulWidget {
  const EventApp({super.key});

  @override
  _EventAppState createState() => _EventAppState();
}

class _EventAppState extends State<EventApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = !isDarkMode;
      prefs.setBool('isDarkMode', isDarkMode);
    });
  }

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
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: EventListScreen(toggleTheme: _toggleThemeMode),
    );
  }
}

class EventListScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const EventListScreen({super.key, required this.toggleTheme});

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> events = [
    {
      'title': 'Tech Conference',
      'date': 'March 10, 2025',
      'image': 'assets/images/tech_conference.jpg'
    },
    {
      'title': 'Music Festival',
      'date': 'April 5, 2025',
      'image': 'assets/images/music_festival.jpg'
    },
    {
      'title': 'Startup Meetup',
      'date': 'May 20, 2025',
      'image': 'assets/images/startup_meetup.jpg'
    },
  ];

  List<Map<String, String>> _bookmarkedEvents = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarkedEvents();
  }

  void _loadBookmarkedEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final savedBookmarks = prefs.getString('bookmarkedEvents');
    if (savedBookmarks != null) {
      setState(() {
        _bookmarkedEvents =
            List<Map<String, String>>.from(json.decode(savedBookmarks));
      });
    }
  }

  void _toggleBookmark(Map<String, String> event) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bool isBookmarked =
          _bookmarkedEvents.any((e) => e['title'] == event['title']);
      if (isBookmarked) {
        _bookmarkedEvents.removeWhere((e) => e['title'] == event['title']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event removed from bookmarks!')),
        );
      } else {
        _bookmarkedEvents.add(event);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added to bookmarks!')),
        );
      }
      prefs.setString('bookmarkedEvents', json.encode(_bookmarkedEvents));
    });
  }

  void _addEvent() {
    setState(() {
      events.add({
        'title': 'New Event',
        'date': 'June 15, 2025',
        'image': 'assets/images/default_event.jpg'
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      _buildEventList(),
      BookedEventsScreen(bookmarkedEvents: _bookmarkedEvents),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search events...',
            border: InputBorder.none,
          ),
          onChanged: (value) =>
              setState(() => _searchQuery = value.toLowerCase()),
        ),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: screens[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
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
    final filteredEvents = events
        .where((event) =>
            event['title']!.toLowerCase().contains(_searchQuery) ||
            event['date']!.toLowerCase().contains(_searchQuery))
        .toList();

    return ListView.builder(
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(filteredEvents[index]['image']!,
                    height: 150, width: double.infinity, fit: BoxFit.cover),
              ),
              ListTile(
                title: Text(filteredEvents[index]['title']!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(filteredEvents[index]['date']!),
                trailing: IconButton(
                  icon: Icon(
                    _bookmarkedEvents.any(
                            (e) => e['title'] == filteredEvents[index]['title'])
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  ),
                  onPressed: () => _toggleBookmark(filteredEvents[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BookedEventsScreen extends StatelessWidget {
  final List<Map<String, String>> bookmarkedEvents;

  const BookedEventsScreen({super.key, required this.bookmarkedEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookmarkedEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(bookmarkedEvents[index]['title']!),
          subtitle: Text(bookmarkedEvents[index]['date']!),
        );
      },
    );
  }
}
