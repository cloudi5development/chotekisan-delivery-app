import 'package:chotekisan_delivery_app/Screen/Incentives_Rewards/incentives_rewards_controller.dart';
import 'package:get/get.dart';

class IncentivesRewardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IncentivesRewardsController>(IncentivesRewardsController());
  }
}
