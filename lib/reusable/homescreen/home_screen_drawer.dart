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
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.75,
                  image: AssetImage("assets/images/prismLogo.png")),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Meet the Devs",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
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
