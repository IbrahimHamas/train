import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(onPressed: calling, child: const Text("Phone Call")),
              TextButton(onPressed: sendSMS, child: const Text("Send SMS ")),
              TextButton(onPressed: email, child: Text("Send Email")),
              TextButton(onPressed: whatsapp, child: Text("Whats App")),
              TextButton(onPressed: messenger, child: Text("Messenger")),
            ],
          ),
        ),
      ),
    );
  }

  calling() async {
    Uri url = Uri.parse("tel:+201099408304");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not $url";
    }
  }

  whatsapp() async {
    final Uri url = Uri.parse("https://wa.me/201099408304?text=ibrahim");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not $url";
    }
  }

  messenger() async {
    final Uri url = Uri.parse("http://m.me/يومياتي");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Could not $url";
    }
  }

  Future<void> sendSMS() async {
    final Uri smsUri = Uri.parse('sms:+201099408304?body=Hi');
    if (!await launchUrl(smsUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $smsUri');
    }
  }

  email() async {
    final Uri _emailUrl = Uri(
      scheme: 'mailto',
      path: 'abrahymhms909@gmail.com',
      queryParameters: {
        'subject': 'Hello Ibrahim you are agood engineer',
        'body': ' I will be a great engineer'
      },
    );

    if (await canLaunchUrl(_emailUrl)) {
      await launchUrl(_emailUrl);
    } else {
      throw "Could not launch $_emailUrl";
    }
  }
}
