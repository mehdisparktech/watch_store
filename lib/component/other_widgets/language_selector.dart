import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/languages/language_controller.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'language'.tr,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children:
                  LanguageController.languages.entries.map((entry) {
                    final languageName = entry.key;
                    final isSelected =
                        languageController.currentLanguageName == languageName;

                    return ListTile(
                      title: Text(languageName),
                      trailing:
                          isSelected
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                      onTap:
                          () => languageController.changeLanguage(languageName),
                      tileColor: isSelected ? Colors.blue.shade50 : null,
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
