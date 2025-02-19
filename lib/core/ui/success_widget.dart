
import 'package:flutter/material.dart';

import '../theme/app_style.dart';

class MessageWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  final String text;
  const MessageWidget(this.text, this.voidCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: const Color.fromRGBO(50, 50, 56, 1),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyles()
                  .mediumBlack
                  .copyWith(color: AppColors().white),
            ),
            GestureDetector(
              child: Text(
                "Go Back!",
                style: AppTextStyles()
                    .mediumBlack
                    .copyWith(color: AppColors().primaryColor),
              ),
              onTap: () {
                voidCallback();
              },
            ),
          ],
        ),
      ),
    );
  }
}
