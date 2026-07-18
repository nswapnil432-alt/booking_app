import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/extension/sized_box_extension.dart';
import 'package:get/get.dart';
import '../../utils/localiization/localization_extension.dart';
import '../../utils/localiization/localization_manager.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/navigation/app_routes.dart';
import '../../utils/themes/app_text_style.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final ValueNotifier<String> selectedLanguage = ValueNotifier<String>(
    'english',
  );

  final LocalizationManager _localizationManager = LocalizationManager();

  final List<LanguageOption> languages = [
    LanguageOption(
      id: 'english',
      name: 'English',
      nativeName: 'English',
      color: const Color(0xFFDCEEFE),
      textColor: const Color(0xFF2563EB),
    ),
    LanguageOption(
      id: 'marathi',
      name: 'Marathi',
      nativeName: 'मराठी',
      color: AppColors.whiteColor,
      textColor: AppColors.emeraldGreen,
    ),
    LanguageOption(
      id: 'more',
      name: 'Regional Languages Coming Soon',
      nativeName: 'More',
      color: AppColors.white,
      textColor: AppColors.slateGray,
    ),
  ];


  Future<void> _changeLanguage(String languageCode) async {
    Locale? locale;

    switch (languageCode) {
      case 'english':
        locale = const Locale('en', 'US');
        break;
      case 'marathi':
        locale = const Locale('mr', 'IN');
        break;
      default:
       
        return;
    }

    try {
      await _localizationManager.changeLocale(locale);

      Get.updateLocale(locale);

      debugPrint('✅ Language changed to: ${locale.languageCode}');
    } catch (e) {
      debugPrint('❌ Error changing language: $e');
    }
    }

  void _handleGetStarted(BuildContext context) async {
    final selectedLang = selectedLanguage.value;
    debugPrint('Selected Language: $selectedLang');

    await _changeLanguage(selectedLang);

    if (context.mounted) {
      context.push(AppRoutes.onbordingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.height,

                    Text(
                      'Welcome, Citizen 👋',
                      style: AppTextStyle.hintStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),

                    32.height,

                    Text(
                     context.selectlanguageSafe,
                      style: AppTextStyle.hintStyle.copyWith(
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    16.height,

                    ValueListenableBuilder<String>(
                      valueListenable: selectedLanguage,
                      builder: (context, value, _) {
                        return Column(
                          children: languages.map((language) {
                            final isSelected = value == language.id;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildLanguageCard(
                                language,
                                isSelected,
                                () async {
                                 
                                  if (language.id == 'more') {
                                    return;
                                  }
                                  selectedLanguage.value = language.id;

                                  await _changeLanguage(language.id);
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () => _handleGetStarted(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: AppTextStyle.hintStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    LanguageOption language,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.buttonBlueDark
                : AppColors.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
           
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: language.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  language.nativeName.substring(0, 2).toUpperCase(),
                  style: AppTextStyle.hintStyle.copyWith(
                    color: language.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            16.width,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.nativeName,
                    style: AppTextStyle.hintStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  2.height,
                  Text(
                    language.name,
                    style: AppTextStyle.hintStyle.copyWith(
                      fontSize: 12,
                      color: AppColors.dividerColor,
                    ),
                  ),
                ],
              ),
            ),

            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.buttonBlueDark,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}

class LanguageOption {
  final String id;
  final String name;
  final String nativeName;
  final Color color;
  final Color textColor;

  LanguageOption({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.color,
    required this.textColor,
  });
}
