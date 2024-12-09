import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String iconPic;
  final String title;
  final void Function(String) onTap;
  final void Function()? onLongPress;

  const MenuItem({
    required this.iconPic,
    required this.title,
    required this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(
        Icons.open_in_new,
        color: Color.fromARGB(255, 128, 127, 127),
      ),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(iconPic),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      onTap: () => onTap(title),
      onLongPress: onLongPress,
      minVerticalPadding: 15,
    );
  }
}
