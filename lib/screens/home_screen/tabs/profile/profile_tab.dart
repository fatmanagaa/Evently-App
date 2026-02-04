import 'package:flutter/material.dart';

import 'language/language_bottom_sheet.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('language'),
              IconButton(onPressed: () {
                showLanguageDialog(context);
              },
                  icon: Icon(Icons.arrow_forward_ios_rounded)),
            ],
          ),
        )
      ],
    );
  }
  void showLanguageDialog(BuildContext context) {


    showModalBottomSheet(context: context, builder: (context) => LanguageBottomSheet(),);
  }

}
