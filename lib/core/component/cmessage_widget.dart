import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSender;
  final String? imagePath;
  final String time;
  final bool isDelivered;
  final bool isSeen;

  const ChatMessage({
    super.key,
    required this.message,
    required this.isSender,
    this.imagePath,
    required this.time,
    this.isDelivered = false,
    this.isSeen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isSender
          ? const EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 50)
          : const EdgeInsets.only(top: 5, bottom: 5, right: 50, left: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: isSender ? Color(0xFFEFFFDE) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft:
              isSender ? const Radius.circular(12) : const Radius.circular(0),
          bottomRight:
              isSender ? const Radius.circular(0) : const Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                margin: const EdgeInsets.only(right: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: AssetImage(imagePath!),
                  ),
                ),
              ),
            ),
          Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: isSender ? Color(0xFF91C57E) : Color(0xFFABB3BB),
                  fontSize: 12,
                ),
              ),
              if (isSender)
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(
                    _getStatusIcon(),
                    color: _getStatusColor(),
                    size: 16,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    if (isSeen) {
      return Icons.done_all;
    } else if (isDelivered) {
      return Icons.done;
    } else {
      return Icons.error;
    }
  }

  Color _getStatusColor() {
    if (isSeen) {
      return Colors.blue;
    } else if (isDelivered) {
      return Colors.white70;
    } else {
      return Colors.red;
    }
  }
}
