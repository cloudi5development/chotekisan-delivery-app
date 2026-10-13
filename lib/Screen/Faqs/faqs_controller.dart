import 'package:get/get.dart';

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

class FaqsController extends GetxController {
  /// Index of the open question, -1 when everything is collapsed.
  final RxInt expandedIndex = 0.obs;

  // Sample data. TODO: load faqs from api.
  final List<FaqItem> faqs = [
    FaqItem(
      question: "How do I go online to receive orders?",
      answer:
          "Turn on the Online toggle from the Home screen. You will start receiving delivery requests based on your assigned zone or selected area.",
    ),
    FaqItem(
      question: "Why am I not receiving any orders?",
      answer:
          "Make sure you are online and within your assigned zone during your selected slot. Order volume can also vary based on customer demand in your area.",
    ),
    FaqItem(
      question: "Can I reject a delivery request?",
      answer:
          "Yes, you can skip a delivery request before accepting it. Frequent rejections may affect your acceptance rating and incentives.",
    ),
    FaqItem(
      question: "Can I change my delivery zone?",
      answer:
          "Yes, you can request a zone change from the Select Zone screen or by contacting our support team. The change applies from your next slot.",
    ),
    FaqItem(
      question: "What if customer gives the wrong OTP?",
      answer:
          "Ask the customer to recheck the OTP in their app. If it still does not match, contact support from the order screen before completing the delivery.",
    ),
    FaqItem(
      question: "How are my earnings calculated?",
      answer:
          "Earnings include the per-delivery payout, distance pay, and any incentives or bonuses you unlock. You can see the breakup on the Earnings screen.",
    ),
    FaqItem(
      question: "When will my earnings be credited?",
      answer:
          "Earnings are settled to your registered bank account or UPI every week. Incentives are credited within 24-48 hours after meeting the criteria.",
    ),
    FaqItem(
      question: "How can I contact Support?",
      answer:
          "You can chat with us from the Message Centre, call our support executive, or email us from the Help & Support screen.",
    ),
  ];

  void toggle(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }
}
