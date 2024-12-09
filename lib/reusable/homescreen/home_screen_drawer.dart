import 'package:app_linkster/app_linkster.dart';
import 'package:dramatic_outputs/reusable/homescreen/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openLinkedinProfile(String username) async {
  final Uri linkedinWebUri =
      Uri.parse('https://www.linkedin.com/in/$username/');
  final launcher = AppLinksterLauncher();
  await launcher.launchThisGuy(
    linkedinWebUri.toString(),
    fallbackLaunchMode: LaunchMode.externalApplication,
  );
}

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: const Column(
              children: [
                Text(
                  'Developed by',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "Prism Team",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          MenuItem(
            iconPic: "assets/images/devpics/utsav_linkedinpic.jpeg",
            title: "Utsav Jaiswal",
            onTap: (title) => openLinkedinProfile("iamutsavjaiswal"),
          ),
          MenuItem(
            iconPic: "assets/images/devpics/madan_linkedinpic.jpeg",
            title: "Madan Raj Upadhyay",
            onTap: (title) =>
                openLinkedinProfile("madan-raj-upadhyay-18b869227"),
          ),
          MenuItem(
            iconPic: "assets/images/devpics/ukasha_linkedinpic.jpeg",
            title: "Ukasha Ahmed",
            onTap: (title) => openLinkedinProfile("ukasha-ahmad-749401200"),
          ),
          MenuItem(
            iconPic: "assets/images/devpics/aditya_linkedinpic.jpeg",
            title: "Aditya Vikram Singh",
            onTap: (title) =>
                openLinkedinProfile("aditya-vikram-singh-50602a25b"),
          ),
        ],
      ),
    );
  }
}
