import 'package:get/get.dart';

class Incentive {
  final String title;
  final String description;
  final int target;
  final int completed;
  final int amount;
  final bool isEarned;

  Incentive({
    required this.title,
    required this.description,
    required this.target,
    required this.completed,
    required this.amount,
    this.isEarned = false,
  });

  double get progress =>
      target == 0 ? 0 : (completed / target).clamp(0.0, 1.0);
}

class IncentivesRewardsController extends GetxController {
  // Sample data. TODO: load incentives and earnings from api.
  final RxInt totalEarnings = 2350.obs;
  final RxInt growthPercent = 18.obs;

  final RxList<Incentive> incentives = <Incentive>[].obs;

  @override
  void onInit() {
    super.onInit();
    incentives.addAll([
      Incentive(
        title: "Daily Delivery Bonus",
        description: "Complete 10 deliveries in a day",
        target: 10,
        completed: 10,
        amount: 150,
        isEarned: true,
      ),
      Incentive(
        title: "Daily Delivery Bonus",
        description: "Complete 10 deliveries in a day",
        target: 10,
        completed: 6,
        amount: 150,
      ),
      Incentive(
        title: "Daily Delivery Bonus",
        description: "Complete 10 deliveries in a day",
        target: 10,
        completed: 6,
        amount: 150,
      ),
      Incentive(
        title: "Daily Delivery Bonus",
        description: "Complete 10 deliveries in a day",
        target: 10,
        completed: 10,
        amount: 150,
        isEarned: true,
      ),
      Incentive(
        title: "Daily Delivery Bonus",
        description: "Complete 10 deliveries in a day",
        target: 10,
        completed: 6,
        amount: 150,
      ),
    ]);
  }
}
