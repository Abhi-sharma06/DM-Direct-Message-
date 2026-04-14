import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class WhatsappScreen extends StatefulWidget {
  const WhatsappScreen({super.key});

  @override
  State<WhatsappScreen> createState() => _WhatsappScreenState();
}

class _WhatsappScreenState extends State<WhatsappScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String completeNumber = '';

  void _launchWhatsAppChat(String number, BuildContext context) async {
    final urlString = 'https://wa.me/$number';
    final uri = Uri.parse(urlString);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Enter the number correctly and try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleLaunch(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _launchWhatsAppChat(completeNumber, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen,

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("assets/images/ogo.png", height: 55),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  Image.asset("assets/animations/whatsapp.gif", height: 300),
                  const SizedBox(height: 50),

                  Form(
                    key: _formKey,
                    child: SizedBox(
                      width: 350,
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          hintText: "Enter Phone Number",
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          filled: true,
                          fillColor: Colors.lightBlue.shade700.withOpacity(0.3),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.white, width: 4.0),
                          ),
                        ),

                        initialCountryCode: 'IN',

                        style: const TextStyle(color: Colors.white),

                        dropdownTextStyle: const TextStyle(color: Colors.black),

                        onChanged: (phone) {
                          completeNumber = phone.completeNumber;
                        },

                        validator: (phone) {
                          if (phone == null || phone.number.isEmpty) {
                            return "Enter phone number";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton.icon(
                    onPressed: () => _handleLaunch(context),
                    icon: const Icon(Icons.messenger, color: Colors.green),
                    label: const Text(
                      " Send Message",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }
}