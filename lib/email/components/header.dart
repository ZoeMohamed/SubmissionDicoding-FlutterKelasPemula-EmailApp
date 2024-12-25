import 'package:flutter/material.dart';
import 'package:submission_dicoding/responsive.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          if (Responsive.isMobile(context)) const BackButton(),

      
        ],
      ),
    );
  }
}
