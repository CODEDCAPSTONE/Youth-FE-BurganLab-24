import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  final VoidCallback? onBack;

  const Navigation({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onBack ??
                () {
                  Navigator.pop(context);
                },
            child: Container(
              width: 24,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.network(
                'https://dashboard.codeparrot.ai/api/assets/Z496wrJ_hFeCeO20',
                width: 24,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardDetails extends StatefulWidget {
  final String balance;
  final String cardHolderName;
  final String cvv;

  const CardDetails({
    Key? key,
    this.balance = '100 KWD',
    this.cardHolderName = 'Hussain Alqallaf',
    this.cvv = '123',
  }) : super(key: key);

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('assets/images/background.png'),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isFlipped = !_isFlipped;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.25,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    final rotate = Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(3.14159 * animation.value);
                    return Transform(
                      transform: rotate,
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                  child: child,
                );
              },
              child: !_isFlipped ? _buildFrontCard() : _buildBackCard(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFrontCard() {
    return Container(
      key: ValueKey<bool>(false),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E44D0),
            Color(0xFF317ED7),
          ],
          stops: [0.1349, 1.0975],
        ),
        border: Border.all(color: Color(0xFF979797)),
      ),
      child: Stack(
        children: [
          // Card Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              'https://dashboard.codeparrot.ai/api/assets/Z4960bJ_hFeCeO21',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Card Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.54,
                          child: Text(
                            'Current Balance',
                            style: TextStyle(
                              fontFamily: 'Cera Pro',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          widget.balance,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      'https://dashboard.codeparrot.ai/api/assets/Z4960bJ_hFeCeO22',
                      width: 45,
                      height: 36,
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  widget.cardHolderName,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFCCCCCC),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'View Card Details',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '**/**',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      key: ValueKey<bool>(true),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E44D0),
            Color(0xFF317ED7),
          ],
          stops: [0.1349, 1.0975],
        ),
        border: Border.all(color: Color(0xFF979797)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CVV: ${widget.cvv}',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Tap to flip back',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionSection_ActionButtons extends StatelessWidget {
  const TransactionSection_ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1873B9),
            Color(0xFF2DCDCD),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Section
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 45,
            decoration: BoxDecoration(
              color: Color(0x66CDCDCD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Transactions Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'TRANSACTIONS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.64,
                color: Colors.black,
              ),
            ),
          ),

          // Transaction Item
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFFD7DCE4),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'T',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Talabat transaction',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'March 31, 2022',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '-100 KWD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: Colors.white.withOpacity(0.3),
            thickness: 1,
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Transfer',
                    'https://dashboard.codeparrot.ai/api/assets/Z4960rJ_hFeCeO23'),
                _buildActionButton('Lock',
                    'https://dashboard.codeparrot.ai/api/assets/Z4960rJ_hFeCeO24'),
                _buildActionButton('Change\nPen',
                    'https://dashboard.codeparrot.ai/api/assets/Z4960rJ_hFeCeO25'),
                _buildActionButton('Withdraw',
                    'https://dashboard.codeparrot.ai/api/assets/Z4960rJ_hFeCeO26'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, String iconPath) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2A98DE),
                Color(0xFF4FAAF0),
                Color(0xFFD9D9D9),
              ],
              stops: [0.2979, 0.4083, 0.728],
            ),
          ),
          child: Center(
            child: Image.network(
              iconPath,
              width: 24,
              height: 24,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF0E0E5F),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
