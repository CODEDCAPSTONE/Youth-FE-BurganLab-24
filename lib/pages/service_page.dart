import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:flutter/services.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEEEE),
      body: SafeArea(
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Image.network(
                'https://dashboard.codeparrot.ai/api/assets/Z4y-br9JV5SvYOjo',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                // Services title
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    'Services',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0168AA),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),

                // Grid of services
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 173 / 210,
                    children: [
                      // Transfer Card
                      ServiceCard(
                        backgroundColor: const Color(0x40000000),
                        icon:
                            'https://dashboard.codeparrot.ai/api/assets/Z4y-br9JV5SvYOjq',
                        title: 'Transfer',
                        subtitle: 'between accounts',
                        titleColor: Colors.black,
                        onTap: () {
                          // Handle Transfer card tap
                        },
                      ),

                      // Budget Card
                      ServiceCard(
                        backgroundColor: const Color(0x401593E4),
                        icon:
                            'https://dashboard.codeparrot.ai/api/assets/Z4y-br9JV5SvYOjr',
                        title: 'Budget',
                        titleColor: const Color(0xFF1593E4),
                        onTap: () {
                          // Handle Budget card tap
                        },
                      ),

                      // Referral Card
                      ServiceCard(
                        backgroundColor: const Color(0x409E59FF),
                        icon:
                            'https://dashboard.codeparrot.ai/api/assets/Z4y-br9JV5SvYOjs',
                        title: 'Get 10 KD by\nreferring a friend',
                        titleColor: const Color(0xFF9E59FF),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Referral QR Code'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/qrcode.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text('Let your friend scan it'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),

                      // Contact Card
                      ServiceCard(
                        backgroundColor: const Color(0x40F78F1E),
                        icon:
                            'https://dashboard.codeparrot.ai/api/assets/Z4y-br9JV5SvYOjt',
                        title: 'Contact us',
                        titleColor: const Color(0xFFF78F1E),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Contact Us'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Phone: 1804080',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy),
                                          onPressed: () {
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text: '1804080'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Phone number copied')),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Email: info@burgan.com',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.copy),
                                          onPressed: () {
                                            Clipboard.setData(
                                                const ClipboardData(
                                                    text: 'info@burgan.com'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content:
                                                      Text('Email copied')),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          // Handle floating action button press
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Color backgroundColor;
  final String icon;
  final String title;
  final String? subtitle;
  final Color titleColor;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.titleColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              icon,
              width: 64,
              height: 64,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: titleColor,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
