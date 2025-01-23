import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

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
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => TransferModal(),
                          );
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

class ServiceCard extends StatefulWidget {
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
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: child,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                widget.icon,
                width: 64,
                height: 64,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: widget.titleColor,
              ),
            ),
            if (widget.subtitle != null)
              Text(
                widget.subtitle!,
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

class TransferModal extends StatefulWidget {
  @override
  _TransferModalState createState() => _TransferModalState();
}

class _TransferModalState extends State<TransferModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String? _selectedFromCard;
  String? _selectedToCard;
  final TextEditingController _amountController = TextEditingController();

  final List<String> cards = ['Card ending in 1234', 'Card ending in 5678'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              0, MediaQuery.of(context).size.height * _slideAnimation.value),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transfer Between Cards',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0168AA),
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 24),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'From Card',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    value: _selectedFromCard,
                    items: cards.map((card) {
                      return DropdownMenuItem(
                        value: card,
                        child: Text(card),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFromCard = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'To Card',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    value: _selectedToCard,
                    items: cards.map((card) {
                      return DropdownMenuItem(
                        value: card,
                        child: Text(card),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedToCard = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount (KWD)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement transfer logic
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0168AA),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Transfer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.go("/home");
            },
            iconSize: 30,
            icon: const Icon(Icons.home_filled),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.discount),
          ),
          const SizedBox(
            width: 80,
          ),
          IconButton(
            onPressed: () {
              context.go("/service");
            },
            iconSize: 30,
            icon: const Icon(Icons.category_outlined),
          ),
          IconButton(
            onPressed: () {
              context.go("/more");
            },
            iconSize: 30,
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      backgroundColor: Colors.blue,
      child: const Icon(Icons.send, color: Colors.white),
    );
  }
}
