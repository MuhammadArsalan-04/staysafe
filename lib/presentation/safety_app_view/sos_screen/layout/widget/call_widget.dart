import 'package:flutter/material.dart';
import 'package:stay_safe_user/configurations/res.dart';
import 'package:stay_safe_user/elements/custom_text.dart';
import 'package:stay_safe_user/elements/sizes.dart';

class CallWidget extends StatelessWidget {
  const CallWidget(
      {required this.onTap,
      this.imageIcon,
      this.subtitle,
      this.title,
      super.key});
  final IconData? imageIcon;
  final String? title;
  final String? subtitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF2233e),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  imageIcon!,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              kw10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomText(
                    text: title!,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: subtitle!,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    onTap();
                  },
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
