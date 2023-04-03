import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/accordion.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../utils/symbols.dart';

Map<String, String> about = {
  "Our Values": 'Everyone strives to be a better person next day. We too strive '
      'for that. To achieve this, trust is crucial which necessitates transparency '
      'through clarity. All four values evolve slowly and organically to achieve '
      'quality over quantity.',
  "Our Mission": 'At breakIN, our objective is to make better food easily '
      'available and accessible to working professionals at their workplace by '
      'incorporating technology in omni-channel framework to fuel today’s workforce '
      'for tomorrow\'s India.',
  "Our Vision": 'breakIN aspires to be mother who reminds you not to compromise '
      'with food, a friend who brings you comfort and delight when you eat and a '
      'beloved about whom you boast. We will travel with you right from school to '
      'university to your office.'
};

List<String> profile = [
  'Akshat Jain_Ideator_https://www.linkedin.com/in/akshat-jain-8053115018/_akshatjain281@gmail.com',
  'Vivek Kumar_Full Stack Develper_https://www.linkedin.com/in/vivek-kumar-1b65a2201/_vivekumar2003bsr@gmail.com',
  'Dushant Bansal_Frontend Developer_https://www.linkedin.com/in/dushant-bansal-a4ba78224/_dushantbansal630@gmail.com',
  'Ankit_UI/UX_https://www.linkedin.com/in/ankitjhadesign1405/_jhaankitkumar12@gmail.com',
  'Rohan Babbar_Tech Operations_https://www.linkedin.com/in/rohan-babbar-2020/_rohanbabbar0408@gmail.com',
];

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
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics()
              .applyTo(const ClampingScrollPhysics()),
          children: [
            for (String key in about.keys)
              Accordion(
                header: _buildHeader(key),
                expandedheader: _buildExpandedHeader(key),
                body: _buildBody(about[key]!),
              ),
            // Custom Accordion
            Accordion(
              header: _buildHeader("Our Team"),
              expandedheader: _buildExpandedHeader("Our Team"),
              body: Column(
                  children: List.generate(profile.length, (index) {
                List list = profile[index].split('_');
                return _buildProfile(list[0], list[1], list[2], list[3]);
              })),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildBody(String text) {
    return Column(
      children: [
        Text(text,
            style: Fonts.simTextBlack.copyWith(letterSpacing: 0),
            textAlign: TextAlign.justify),
        const SizedBox(height: 10),
        Container(color: Palette.greyNormal, height: 1),
      ],
    );
  }

  ListTile _buildHeader(String title) {
    return ListTile(
      title: Text(title, style: Fonts.buttonText.copyWith(color: Palette.text)),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      dense: true,
      trailing: const Icon(Icons.keyboard_arrow_down, size: 32),
      shape: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.greyNormal)),
    );
  }

  ListTile _buildExpandedHeader(String title) {
    return ListTile(
      title: Text(title, style: Fonts.buttonText.copyWith(color: Palette.text)),
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      dense: true,
      trailing: const Icon(Icons.keyboard_arrow_up, size: 32),
      shape: null,
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  ListTile _buildProfile(
      String name, String role, String? linkedin, String? mail) {
    return ListTile(
      title: Text(name, style: Fonts.simTextBlack),
      subtitle: Text(role, style: Fonts.simTextBlack),
      trailing: SizedBox(
        width: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () => linkedin == null ? null : _launchUrl(linkedin),
                child: Symbols.linkedinIcon),
            const SizedBox(width: 16.0),
            GestureDetector(
                onTap: () => mail == null ? null : _launchUrl('mailto:$mail'),
                child: Symbols.gmailIcon)
          ],
        ),
      ),
      minVerticalPadding: 0,
      dense: true,
    );
  }
}
