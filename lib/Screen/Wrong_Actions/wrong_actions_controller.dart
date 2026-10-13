import 'package:get/get.dart';

class WrongActionFeedback {
  final String feedbackPoint;
  final String orderId;
  final String dateTime;
  final String feedback;
  final bool isNew;

  WrongActionFeedback({
    required this.feedbackPoint,
    required this.orderId,
    required this.dateTime,
    required this.feedback,
    this.isNew = false,
  });
}

class WrongActionsController extends GetxController {
  final RxList<WrongActionFeedback> feedbacks = <WrongActionFeedback>[].obs;

  List<WrongActionFeedback> get newFeedbacks =>
      feedbacks.where((f) => f.isNew).toList();
  List<WrongActionFeedback> get pastFeedbacks =>
      feedbacks.where((f) => !f.isNew).toList();

  @override
  void onInit() {
    super.onInit();
    // Sample data. TODO: load wrong-action feedbacks from api.
    const sampleFeedback =
        "Delivery was too late, I had waited 20 min more than the expected delivery time.";
    feedbacks.addAll([
      WrongActionFeedback(
        feedbackPoint: "Late Delivery",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
        isNew: true,
      ),
      WrongActionFeedback(
        feedbackPoint: "Rude Behaviour",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
        isNew: true,
      ),
      WrongActionFeedback(
        feedbackPoint: "Damaged Items",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
      ),
      WrongActionFeedback(
        feedbackPoint: "Late Delivery",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
      ),
      WrongActionFeedback(
        feedbackPoint: "Rude Behaviour",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
      ),
      WrongActionFeedback(
        feedbackPoint: "Damaged Items",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
      ),
      WrongActionFeedback(
        feedbackPoint: "Late Delivery",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
      ),
      WrongActionFeedback(
        feedbackPoint: "Rude Behaviour",
        orderId: "OID001",
        dateTime: "08 Jun 2026, 04:17 PM",
        feedback: sampleFeedback,
      ),
    ]);
  }
}
