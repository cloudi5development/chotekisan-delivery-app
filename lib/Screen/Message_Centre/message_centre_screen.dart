import 'package:chotekisan_delivery_app/Screen/Message_Centre/message_centre_controller.dart';
import 'package:chotekisan_delivery_app/common/app_theme.dart';
import 'package:chotekisan_delivery_app/common/assets_path.dart';
import 'package:chotekisan_delivery_app/common/customText.dart';
import 'package:chotekisan_delivery_app/common/custom_app_header.dart';
import 'package:chotekisan_delivery_app/common/responsive_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageCentreScreen extends GetView<MessageCentreController> {
  const MessageCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F3),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const CustomAppHeader(title: "Message Centre", showBack: true),

            // Conversation
            Expanded(
              child: Obx(
                () => ListView.separated(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  itemCount: controller.messages.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final message = controller.messages[index];
                    return message.isMe
                        ? _MyMessageBubble(message: message)
                        : _BotMessageBubble(message: message);
                  },
                ),
              ),
            ),

            // Input bar
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: controller.onAttach,
                      child: SvgPicture.asset(AssetSvgPath.attachmentIcon),
                    ),

                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controller.messageController,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 4,
                        onSubmitted: (_) => controller.sendMessage(),
                        style: TextStyle(
                          fontSize: ResponsiveFontSizes.fontSize16(context),
                          color: myColors?.txt,
                        ),
                        decoration: InputDecoration(
                          hintText: "Ask me anything",
                          hintStyle: TextStyle(
                            fontSize: ResponsiveFontSizes.fontSize16(context),
                            color: myColors?.primaryText,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: controller.sendMessage,
                      child: Icon(
                        Icons.send_rounded,
                        size: 24,
                        color: myColors?.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// White bubble from support with the bot avatar and a timestamp.
class _BotMessageBubble extends GetView<MessageCentreController> {
  final ChatMessage message;

  const _BotMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    MyColors? myColors = Theme.of(context).extension<MyColors>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 38,
          width: 38,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffD2F0D7),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(AssetSvgPath.appIcon),
        ),

        const SizedBox(width: 8),
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.72),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            border: Border.all(color: const Color(0xffEDEFF2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              OnestText(
                text: message.text,
                color: myColors?.txt,
                fontSize: ResponsiveFontSizes.fontSize16(context),
                fontWeight: FontWeight.w500,
                lineHeight: 1.4,
              ),
              const SizedBox(height: 2),
              OnestText(
                text: controller.formatTime(message.time),
                color: myColors?.primaryText,
                fontSize: ResponsiveFontSizes.fontSize13(context),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Green bubble for the partner's own messages.
class _MyMessageBubble extends GetView<MessageCentreController> {
  final ChatMessage message;

  const _MyMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: width * 0.72),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
        decoration: const BoxDecoration(
          color: Color(0xff0A7A10),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnestText(
              text: message.text,
              color: Colors.white,
              fontSize: ResponsiveFontSizes.fontSize16(context),
              fontWeight: FontWeight.w500,
              lineHeight: 1.4,
            ),
            const SizedBox(height: 2),
            OnestText(
              text: controller.formatTime(message.time),
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: ResponsiveFontSizes.fontSize13(context),
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
