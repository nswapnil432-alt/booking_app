import 'package:flutter/material.dart';
import '../extension/sized_box_extension.dart';
import '../constants/app_colors.dart';
import '../themes/app_text_style.dart';

class CustomCalendarWidget extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime) onDateSelected;
  final String title;

  const CustomCalendarWidget({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.title = 'Select Date',
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  late DateTime _currentDate;
  late DateTime _selectedDate;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _pageController = PageController(
      initialPage: _getMonthDifference(DateTime.now(), _currentDate),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _getMonthDifference(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + end.month - start.month;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // Use 70% of screen height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.bottomBarBackColor,
            AppColors.bottomBarBackColor.withValues(alpha: 0.9),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16), // Reduced padding
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.parentBgColor.withValues(alpha: 0.1),
                  AppColors.parentBgColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              children: [
                // Drag Handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                12.height, // Reduced spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyle.smallNormalText.copyWith(
                        fontSize: 18, // Slightly smaller
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Calendar Header with Navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Reduced vertical padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => _previousMonth(),
                  icon: Container(
                    padding: const EdgeInsets.all(6), // Smaller padding
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.white,
                      size: 20, // Smaller icon
                    ),
                  ),
                ),
                Text(
                  _getMonthYearString(_currentDate),
                  style: AppTextStyle.smallNormalText.copyWith(
                    fontSize: 16, // Slightly smaller
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => _nextMonth(),
                  icon: Container(
                    padding: const EdgeInsets.all(6), // Smaller padding
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: AppColors.white,
                      size: 20, // Smaller icon
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Weekday Headers
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // Added vertical padding
            child: Row(
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: AppTextStyle.smallNormalText.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.parentBgColor,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),

          // Calendar Grid - Use Expanded with flex to take available space
          Expanded(
            flex: 3, // Give more space to calendar
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentDate = DateTime(
                      DateTime.now().year,
                      DateTime.now().month + index,
                    );
                  });
                },
                itemBuilder: (context, index) {
                  final month = DateTime(
                    DateTime.now().year,
                    DateTime.now().month + index,
                  );
                  return _buildCalendarGrid(month);
                },
              ),
            ),
          ),

          // Selected Date Display and Confirm Button
          Container(
            padding: const EdgeInsets.all(10), // Reduced padding
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.05),
              border: Border(
                top: BorderSide(
                  color: AppColors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.event,
                      color: AppColors.parentBgColor,
                      size: 18, // Smaller icon
                    ),
                    1.width, // Reduced spacing
                    Text(
                      'Selected: ${_formatDate(_selectedDate)}',
                      style: AppTextStyle.smallNormalText.copyWith(
                        fontSize: 14, // Smaller text
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                12.height, // Reduced spacing
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onDateSelected(_selectedDate);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.parentBgColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12), // Reduced padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: Text(
                      'Confirm Selection',
                      style: AppTextStyle.smallNormalText.copyWith(
                        fontSize: 12, // Smaller text
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                20.height
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final firstDayWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;

    // Calculate total cells needed (minimum 6 rows to show all dates properly)
    final totalCells = ((daysInMonth + firstDayWeekday) / 7).ceil() * 7;
    final actualRows = (totalCells / 7).ceil();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: actualRows * 7, // Ensure we have enough rows
      itemBuilder: (context, index) {
        final dayIndex = index - firstDayWeekday;
        if (dayIndex < 0 || dayIndex >= daysInMonth) {
          return const SizedBox(); // Empty cells
        }

        final day = dayIndex + 1;
        final date = DateTime(month.year, month.month, day);
        final isSelected = _isSameDay(date, _selectedDate);
        final isToday = _isSameDay(date, DateTime.now());
        final isDisabled = _isDateDisabled(date);

        return GestureDetector(
          onTap: isDisabled ? null : () {
            setState(() {
             _selectedDate = date;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.parentBgColor
                  : isToday
                      ? AppColors.parentBgColor.withValues(alpha: 0.2)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isToday && !isSelected
                  ? Border.all(color: AppColors.parentBgColor, width: 1)
                  : null,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: AppTextStyle.smallNormalText.copyWith(
                  fontSize: 14,
                  fontWeight:
                      isSelected || isToday ? FontWeight.bold : FontWeight.w500,
                  color: isDisabled
                      ? AppColors.white.withValues(alpha: 0.3)
                      : isSelected
                          ? Colors.white
                          : AppColors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isDateDisabled(DateTime date) {
    if (widget.firstDate != null && date.isBefore(widget.firstDate!)) {
      return true;
    }
    if (widget.lastDate != null && date.isAfter(widget.lastDate!)) {
      return true;
    }
    return false;
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  void _previousMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}