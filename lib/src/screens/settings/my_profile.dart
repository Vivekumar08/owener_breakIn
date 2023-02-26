import 'package:flutter/material.dart';
import '../../components/input_field.dart';
import '../../components/button.dart';
import '../../style/fonts.dart';
import '../../style/palette.dart';
import '../../utils/images.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController location = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 72.0,
        title: Text("My Profile", style: Fonts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
                inputText: "Name*",
                hintText: "Enter Your Name",
                controller: name),
            InputField(
                inputText: "Address*",
                hintText: "Enter Your Address",
                controller: phone,
                isPhone: true),
            InputField(
                inputText: "Email*",
                hintText: "Enter Your Email",
                controller: email),
            InputField(
                inputText: "Owner Name *",
                hintText: "Enter Owner Name",
                controller: location),
            const SizedBox(height: 16.0),
            Text('Document *', style: Fonts.inputText),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Images.dummy,
                const SizedBox(width: 16.0),
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Palette.stroke,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(Icons.square_outlined),
                      Icon(Icons.add, size: 16.0)
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Button(onPressed: () {}, buttonText: 'Save Changes')
          ],
        ),
      ),
    );
  }
}
