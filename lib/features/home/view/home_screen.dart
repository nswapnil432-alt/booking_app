import 'package:flutter/material.dart';
import '../../login/view/login_screen.dart'; // For reusing DiyaWidget
import '../widget/booked_events_list.dart';
import '../widget/popular_categories.dart';
import '../../services/view/services_screen.dart';
import '../widget/app_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // State for bottom nav bar

  // Segment index state inside the home tab (0: Book, 1: Events, 2: Requests)
  int _selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0), // Soft warm background
      body: SafeArea(
        child: Column(
          children: [
            // Screen content switcher based on active bottom tab
            Expanded(
              child: _currentIndex == 0 
                  ? _buildHomeContent() 
                  : _currentIndex == 1
                      ? const ServicesScreen()
                      : Center(
                          child: Text(
                            _getTabTitle(),
                            style: const TextStyle(
                              fontSize: 20, 
                              color: Color(0xFF5D2E16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
            ),
            // Custom Bottom Navigation Bar matching the mockup
            AppBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getTabTitle() {
    switch (_currentIndex) {
      case 1:
        return "Services Screen";
      case 2:
        return "Good Work Screen";
      case 3:
        return "History Screen";
      case 4:
        return "Profile Screen";
      default:
        return "Home Screen";
    }
  }

  // Home Screen content
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header (Namaskar, Username & Notification Bell)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny_outlined, size: 16, color: Color(0xFF8B7365)),
                      const SizedBox(width: 4),
                      Text(
                        "Namaskar",
                        style: TextStyle(
                          color: const Color(0xFF8B7365).withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "hdhdhdh1",
                    style: TextStyle(
                      fontFamily: 'Serif',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5D2E16),
                    ),
                  ),
                ],
              ),
              // Notification Icon with Badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xFF5D2E16),
                      size: 24,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD35515), // Red badge dot
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2. Promotional Banner (Big gradient orange card)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.0),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF8C2C0C), // Deep reddish-brown orange
                  Color(0xFFDE7322), // Vibrant orange
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8C2C0C).withValues(alpha: 0.25),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Stack(
              children: [
                // Star decoration on the right side
                Positioned(
                  right: -10,
                  top: -10,
                  child: Opacity(
                    opacity: 0.15,
                    child: Icon(Icons.star_purple500_outlined, size: 100, color: Colors.white),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SEVASUR",
                      style: TextStyle(
                        color: Color(0xFFFFD54F),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Find the right artist for\nyour next event",
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Browse services, book in a few taps.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // White button inside banner
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF8C2C0C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Browse services",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D2E16),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 16, color: Color(0xFF5D2E16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. Segment Tab Navigation Card (Middle Card)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                // Segment 1: Book your event
                Expanded(
                  child: _buildSegmentItem(
                    index: 0,
                    icon: Icons.calendar_month_outlined,
                    label: "Book your event",
                  ),
                ),
                // Segment 2: Events you booked
                Expanded(
                  child: _buildSegmentItem(
                    index: 1,
                    icon: Icons.event_available_outlined,
                    label: "Events you booked",
                    badgeCount: 3,
                  ),
                ),
                // Segment 3: Requests for you
                Expanded(
                  child: _buildSegmentItem(
                    index: 2,
                    icon: Icons.work_outline,
                    label: "Requests for you",
                    badgeCount: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 4. Content based on selected segment
          _buildSegmentContent(),
        ],
      ),
    );
  }

  // Segment content switcher
  Widget _buildSegmentContent() {
    switch (_selectedSegment) {
      case 0:
        return Column(
          children: [
            _buildPlanCard(),
            PopularCategories(
              onCategoryTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        );
      case 1:
        return const BookedEventsList();
      case 2:
        return _buildRequestsPlaceholder();
      default:
        return Column(
          children: [
            _buildPlanCard(),
            PopularCategories(
              onCategoryTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          ],
        );
    }
  }

  // Segment 1 Content: Plan your event card
  Widget _buildPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: const Color(0xFFEFE6DB), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DiyaWidget(),
          const SizedBox(height: 16),
          const Text(
            "Plan your next event",
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E16),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Browse trusted artists by category and book in just a few taps.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8B7365),
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          // Start booking button with gradient
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD35515), // Deep orange
                    Color(0xFFE28B2E), // Orange-yellow gradient
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD35515).withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Start booking",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Segment 3 Content: Requests for you placeholder
  Widget _buildRequestsPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: const Color(0xFFEFE6DB), width: 1.0),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail_outline, size: 48, color: Color(0xFF8B7365)),
          SizedBox(height: 16),
          Text(
            "Requests for you",
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E16),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "You have 1 pending service request waiting for your review.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8B7365),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for segment tab item
  Widget _buildSegmentItem({
    required int index,
    required IconData icon,
    required String label,
    int? badgeCount,
  }) {
    final isSelected = _selectedSegment == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSegment = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDE7322) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : const Color(0xFF8B7365),
                  size: 24,
                ),
                if (badgeCount != null && badgeCount > 0)
                  Positioned(
                    top: -6,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD35515), // Red badge
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF5D2E16),
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }


}