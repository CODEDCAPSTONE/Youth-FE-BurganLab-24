import 'package:flutter/material.dart';
import 'package:frontend/pages/form_ready.dart';
import 'package:go_router/go_router.dart';

class UniversitySelectionPage extends StatefulWidget {
  const UniversitySelectionPage({super.key});

  @override
  _UniversitySelectionPageState createState() =>
      _UniversitySelectionPageState();
}

class _UniversitySelectionPageState extends State<UniversitySelectionPage> {
  String searchQuery = '';

  final List<Map<String, String>> universities = [
    {
      'name': 'Kuwait University',
      'logo': 'assets/images/kuwaituni.jpg',
    },
    {
      'name': 'American University of Kuwait',
      'logo': 'assets/images/auk.png',
    },
    {
      'name': 'Gulf University for Science and Technology',
      'logo': 'assets/images/gulf.png',
    },
    {
      'name': 'Australian College of Kuwait',
      'logo': 'assets/images/au.png',
    },
    {
      'name': 'Arab Open University',
      'logo': 'assets/images/aou.png',
    },
    {
      'name': 'American University of the Middle East',
      'logo': 'assets/images/aum.jpg',
    },
    {
      'name': 'Box Hill College Kuwait',
      'logo': 'assets/images/bhck.png',
    },
    {
      'name': 'Kuwait International Law School',
      'logo': 'assets/images/klaw.png',
    },
  ];

  List<Map<String, String>> get filteredUniversities {
    return universities.where((university) {
      return university['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade100],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => context.pop(),
                ),
              ),

              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Select university',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Universities List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredUniversities.length,
                  itemBuilder: (context, index) {
                    final university = filteredUniversities[index];
                    return UniversityCard(
                      name: university['name']!,
                      logo: university['logo']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                FormReadyPage(
                                    universityName: university['name']!),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(1.0, 0.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UniversityCard extends StatelessWidget {
  final String name;
  final String logo;
  final VoidCallback onTap;

  const UniversityCard({
    super.key,
    required this.name,
    required this.logo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                // University Logo
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: logo.startsWith('assets/')
                        ? Image.asset(
                            logo,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.school, color: Colors.blue);
                            },
                          )
                        : Image.network(
                            logo,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.school, color: Colors.blue);
                            },
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                // University Name
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
