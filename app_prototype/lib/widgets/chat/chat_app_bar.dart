import 'package:flutter/material.dart';

import '../users/user_icon.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String userName, userLocation;

  const ChatAppBar({super.key,
    required this.userName, required this.userLocation});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName),
              Text(userLocation,
                style: const TextStyle(fontWeight: FontWeight.w300),),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 70,
                width: 70,
                child: const UserIcon(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}