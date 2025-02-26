import 'package:cool_background_animation/cool_background_animation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortfolioScreen(),
    );
  }
}

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isExpanded = false;
  bool _isMobileView = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  void _launchGitHub() {
    _launchURL('https://github.com/devesh');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _isMobileView = constraints.maxWidth < 600;

        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: const Text('Devesh Portfolio',
                style: TextStyle(color: Colors.white)),
            actions: [
              IconButton(
                icon: const Icon(Icons.contact_mail, color: Colors.white),
                onPressed: () => _launchURL('mailto:devesh.email@example.com'),
              ),
              IconButton(
                icon: const Icon(Icons.code, color: Colors.white),
                onPressed: _launchGitHub,
              ),
              IconButton(
                icon: const Icon(Icons.phone, color: Colors.white),
                onPressed: () => _launchURL('tel:+919876543210'),
              ),
            ],
          ),
          drawer: _isMobileView ? _buildMobileDrawer() : null,
          body: BubbleBackground(
            backgroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black12,
                  Colors.black26,
                  Colors.black87,
                ],
              ),
            ),
            child: Center(
              child: _isMobileView ? _buildMobileView() : _buildDesktopView(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.black87),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/image/profile.jpeg'),
            ),
          ),
          _buildDrawerItem('About', Icons.person, () {}),
          _buildDrawerItem('Education', Icons.school, () {}),
          _buildDrawerItem('Experience', Icons.work, () {}),
          _buildDrawerItem('Skills', Icons.star, () {}),
          _buildDrawerItem('Contact', Icons.contact_mail,
              () => _launchURL('mailto:devesh.email@example.com')),
          _buildDrawerItem('GitHub', Icons.code, _launchGitHub),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildMobileView() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/image/profile.jpeg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Devesh',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Mobile App Developer',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('ABOUT', Icons.person),
                    const Text(
                      'I am Devesh, a passionate Flutter and AI/ML Developer, dedicated to delivering innovative, user-friendly applications that make a real-world impact.',
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('SKILLS', Icons.star),
                    _buildSkillItem('Dart & Flutter', 0.9),
                    _buildSkillItem('Swift & iOS', 0.8),
                    _buildSkillItem('Machine Learning', 0.6),
                    const SizedBox(height: 20),
                    _buildSectionTitle('EDUCATION', Icons.school),
                    _buildEducationItem('2020-2024',
                        'Bachelor of Technology\nArtificial Intelligence and Machine Learning\nCT University, Ludhiana\n8.1 CGPA'),
                    const SizedBox(height: 20),
                    _buildSectionTitle('EXPERIENCE', Icons.work),
                    _buildExperienceItem(
                        '2018-2020', 'Junior Flutter Developer'),
                    _buildExperienceItem(
                        '2020-2023', 'Senior Flutter & Swift Developer'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopView() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: _isExpanded
                      ? MediaQuery.of(context).size.height * 1.2
                      : MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.grey[300]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Devesh Portfolio',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildSectionTitle(
                                        'EDUCATION', Icons.school),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildEducationItem('2020-2024',
                                                'Bachelor of Technology - Artificial Intelligence and Machine Learning\nCT University, Ludhiana, Punjab, India\n8.1 CGPA\nKey Courses: Basic Programming, OOPs Concepts, Data Warehousing, NLP, Machine Learning Models'),
                                            const SizedBox(height: 30),
                                            _buildSectionTitle(
                                                'EXPERIENCE', Icons.work),
                                            _buildExperienceItem('2018-2020',
                                                'Junior Flutter Developer'),
                                            _buildExperienceItem('2020-2023',
                                                'Senior Flutter & Swift Developer'),
                                            const SizedBox(height: 30),
                                            _buildSectionTitle(
                                                'SKILLS', Icons.star),
                                            _buildSkillItem(
                                                'Dart & Flutter', 0.9),
                                            _buildSkillItem('Swift & iOS', 0.8),
                                            _buildSkillItem(
                                                'UI/UX Design', 0.7),
                                            _buildSkillItem(
                                                'Machine Learning', 0.6),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage: const AssetImage(
                                            'assets/image/profile.jpeg'),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(70),
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text(
                                                      'Profile Details'),
                                                  content: const Text(
                                                    'Mobile App Developer\nFlutter & Swift Specialist\nPassionate about creating innovative solutions',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child:
                                                          const Text('Close'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.email,
                                                color: Colors.white),
                                            onPressed: () => _launchURL(
                                                'mailto:devesh.email@example.com'),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.code,
                                                color: Colors.white),
                                            onPressed: _launchGitHub,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.phone,
                                                color: Colors.white),
                                            onPressed: () =>
                                                _launchURL('tel:+919876543210'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      _buildSectionTitle('ABOUT', Icons.person,
                                          isLight: true),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'I am Devesh, a passionate Flutter and AI/ML Developer, dedicated to delivering innovative, user-friendly applications that make a real-world impact. I specialize in creating seamless user experiences and scalable solutions.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 30),
                                      _buildSectionTitle(
                                          'HOBBIES', Icons.sports,
                                          isLight: true),
                                      const Text(
                                        'Coding, Reading, Traveling, Machine Learning Projects',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 30),
                                      _buildSectionTitle(
                                          'LANGUAGES', Icons.language,
                                          isLight: true),
                                      _buildSkillItem('English', 0.9,
                                          isLight: true),
                                      _buildSkillItem(
                                        'Technical Communication',
                                        0.8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, IconData icon,
      {bool isLight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isLight ? Colors.white : Colors.black, size: 20),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isLight ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationItem(String years, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget _buildExperienceItem(String years, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$years - $title\nProfessional experience in mobile app development',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String skill, double level, {bool isLight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill,
            style:
                TextStyle(color: isLight ? Colors.grey[300] : Colors.black87),
          ),
          const SizedBox(height: 4),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlue,
                  Colors.cyan,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: level,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.cyan,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
