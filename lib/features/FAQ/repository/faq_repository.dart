import '../../../services/api/api_service.dart';
import '../data/model/faq_model.dart';

abstract class FAQRepository {
  Future<List<FAQModel>> getAllFAQs();
}

class FAQRepositoryImpl implements FAQRepository {
  @override
  Future<List<FAQModel>> getAllFAQs() async {
    try {
      final response = await ApiService.get("faqs");

      if (response.isSuccess) {
        final faqResponse = FAQResponse.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        return faqResponse.data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to get FAQs: $e');
    }
  }
}
