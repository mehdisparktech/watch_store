import 'package:get/get.dart';
import '../../data/model/faq_model.dart';
import '../../repository/faq_repository.dart';
import '../../../../utils/enum/enum.dart';

class FAQController extends GetxController {
  // Repository injection
  final FAQRepository _faqRepository = Get.find<FAQRepository>();

  // State variables
  Status status = Status.completed;
  List<FAQModel> faqList = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getFAQs();
  }

  // Load FAQ data
  Future<void> getFAQs() async {
    if (isLoading) return;

    isLoading = true;
    status = Status.loading;
    update();

    try {
      final faqs = await _faqRepository.getAllFAQs();
      faqList = faqs;
      status = Status.completed;
    } catch (e) {
      status = Status.error;
    } finally {
      isLoading = false;
      update();
    }
  }
}
