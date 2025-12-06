import 'package:flutter/material.dart';
import 'package:flutter_app/models/message_bubble.dart';

class MessageBubbleWidget extends StatelessWidget {
  final MessageBubble messageBubble;
  const MessageBubbleWidget({super.key, required this.messageBubble});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:
          messageBubble.isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              alignment:
                  messageBubble.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: messageBubble.isUser ? Colors.blue : Colors.black87,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.only(
                top: 8,
                bottom: 20,
                left: messageBubble.isUser ? 12 : 8,
                right: messageBubble.isUser ? 8 : 48,
              ),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                messageBubble.message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 16,
              child: Text(
                _dateFormat(messageBubble.time),
                style: TextStyle(
                  fontSize: 10,
                  color: messageBubble.isUser ? Colors.grey[700] : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _dateFormat(DateTime timestamp) {
    final hours = timestamp.hour.toString().padLeft(2, '0');
    final minutes = timestamp.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
