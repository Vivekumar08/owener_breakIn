import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/routing_list.dart';
import '../../router/constants.dart';
import '../../style/fonts.dart';
import '../../utils/symbols.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("About Us", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            RoutingList(title: "Our Story", route: ourStory),
            RoutingList(title: "Our Values", route: ourValue),
            RoutingList(title: "Our Mission", route: ourMission),
            RoutingList(title: "Our Team", route: ourTeam),
          ],
        ),
      ),
    );
  }
}

class OurStory extends StatelessWidget {
  const OurStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Our Story", style: Fonts.appBarTitle),
      ),
    );
  }
}

class OurValue extends StatelessWidget {
  const OurValue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Our Value", style: Fonts.appBarTitle),
      ),
    );
  }
}

class OurMission extends StatelessWidget {
  const OurMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Our Mission", style: Fonts.appBarTitle),
      ),
    );
  }
}

class OurTeam extends StatelessWidget {
  const OurTeam({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  _buildProfile({
    required String name,
    Image? image,
    required String role,
    required String linkedin,
    required String mail,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 60.0, backgroundImage: image?.image),
            const SizedBox(height: 8.0),
            Text(name, style: Fonts.appBarTitle),
            const SizedBox(height: 4.0),
            Text(role, style: Fonts.appBarTitle.copyWith(fontSize: 12.0)),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () => _launchUrl(linkedin),
                    child: Symbols.linkedinIcon),
                const SizedBox(width: 16.0),
                GestureDetector(
                    onTap: () => _launchUrl('mailto:$mail'),
                    child: Symbols.gmailIcon)
              ],
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("Our Team", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Center(
                child: _buildProfile(
                    name: 'Akshat Jain',
                    role: 'Ideator',
                    linkedin:
                        'https://www.linkedin.com/in/akshat-jain-8053115018/',
                    mail: 'akshatjain281@gmail.com')),
            const SizedBox(height: 24.0),
            Text("Dev", style: Fonts.appBarTitle),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _buildProfile(
                  name: 'Vivek Kumar',
                  role: 'Full Stack Develper',
                  linkedin:
                      'https://www.linkedin.com/in/vivek-kumar-1b65a2201/',
                  mail: 'vivekumar2003bsr@gmail.com'),
              _buildProfile(
                  name: 'Dushant Bansal',
                  role: 'Frontend Developer',
                  linkedin:
                      'https://www.linkedin.com/in/dushant-bansal-a4ba78224/',
                  mail: 'dushantbansal630@gmail.com')
            ]),
            const SizedBox(height: 24.0),
            Text("Other", style: Fonts.appBarTitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProfile(
                    name: 'Rohan Babbar',
                    role: 'Advisor',
                    linkedin: 'https://www.linkedin.com/in/rohan-babbar-2020/',
                    mail: 'rohanbabbar0408@gmail.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
