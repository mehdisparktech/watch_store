import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/languages/language_controller.dart';

class LanguageSettingTile extends StatelessWidget {
  const LanguageSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Obx(
      () => ListTile(
        leading: const Icon(Icons.language),
        title: Text("language".tr),
        subtitle: Text(languageController.currentLanguageName),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showLanguageDialog(context),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("language".tr),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    LanguageController.languages.entries.map((entry) {
                      final languageName = entry.key;
                      final languageController = Get.find<LanguageController>();

                      return Obx(
                        () => RadioListTile<String>(
                          title: Text(languageName),
                          value: languageName,
                          groupValue: languageController.currentLanguageName,
                          onChanged: (value) {
                            if (value != null) {
                              languageController.changeLanguage(value);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      );
                    }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel".tr),
              ),
            ],
          ),
    );
  }
}
