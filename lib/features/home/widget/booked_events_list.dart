import 'package:flutter/material.dart';

class BookedEventsList extends StatelessWidget {
  const BookedEventsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEventCard(
          title: "Community Gathering",
          status: "CONFIRMED",
          statusColor: const Color(0xFFC2410C),
          statusBgColor: const Color(0xFFFFEDD5),
          artistName: "Artist B",
          date: "12 Jul",
          time: "18:30",
          amount: "₹21,000",
          location: "Area 1, City 1",
        ),
        const SizedBox(height: 16),
        _buildEventCard(
          title: "Procession Event",
          status: "PENDING",
          statusColor: const Color(0xFFB45309),
          statusBgColor: const Color(0xFFFEF3C7),
          artistName: "Group E",
          date: "7 Sept",
          time: "16:00",
          amount: "₹18,000",
          location: "Area 2, City 1",
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String title,
    required String status,
    required Color statusColor,
    required Color statusBgColor,
    required String artistName,
    required String date,
    required String time,
    required String amount,
    required String location,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: const Color(0xFFEFE6DB), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Title & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E16),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Artist Name Subtitle
          RichText(
            text: TextSpan(
              text: "with ",
              style: const TextStyle(
                color: Color(0xFF8B7365),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: artistName,
                  style: const TextStyle(
                    color: Color(0xFF5D2E16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Row of Details: DATE, TIME, AMOUNT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailCapsule("DATE", date),
              _buildDetailCapsule("TIME", time),
              _buildDetailCapsule("AMOUNT", amount),
            ],
          ),
          const SizedBox(height: 16),
          
          // Location Footer
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(
                  color: Color(0xFF8B7365),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper for detail capsule in event card
  Widget _buildDetailCapsule(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF2E8), // Soft cream capsule color
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF8B7365),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF5D2E16),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
