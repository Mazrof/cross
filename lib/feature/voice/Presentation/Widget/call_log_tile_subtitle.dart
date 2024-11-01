import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CallLogTileSubtitle extends StatelessWidget {
  final bool isIncoming;
  final bool isMissed;
  final String callDate;

  const CallLogTileSubtitle(
      {super.key,
      required this.isIncoming,
      required this.isMissed,
      required this.callDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: isIncoming
              ? Icon(
                  Icons.arrow_downward_rounded,
                  color: isMissed ? Colors.red : Colors.green,
                  size: 20,
                )
              : const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.green,
                  size: 20,
                ),
        ),
        Text(
          callDate,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
