
import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({

    super.key, required this.title, required this.desc, required this.image,

  });
  final String title;
  final String desc;
  final String image;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height:  MediaQuery.of(context).size.height / 100 * 35,
          ),
          SizedBox(
            height: ( MediaQuery.of(context).size.height >= 840) ? 60 : 30,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 15),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          )

        ],
      ),
    );
  }
}
