import 'package:abbrefy_application/core/constants/assets.dart';
import 'package:abbrefy_application/core/constants/colors.dart';

import 'package:abbrefy_application/core/service/abbrefy_service.dart';
import 'package:abbrefy_application/core/widgets/reusable_buttons.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService abbrefyService = ApiService();
  final TextEditingController urlController = TextEditingController();

  void _handleResponse(Map<String, dynamic>? responseData) {
    if (responseData != null) {
      // Handle the response data here, you can display it or process it further
      print('Response Data: $responseData');
    } else {
      // Handle the case where the API request failed or returned null
      print('API request failed or returned null.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mBoardwhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                SizedBox(
                  height: 300,
                  child: Image.asset(Assets.image4),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Welcome to abbrefy get your link below 👇",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: urlController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelText: 'Link',
                    hintText: 'Paste your website link here',
                  ),
                  textInputAction: TextInputAction.done,
                  // onEditingComplete: () async {

                  // },
                ),
                const SizedBox(height: 50),
                ColorButton(
                  width: 225,
                  color: mRed,
                  text: 'Abbrefy',
                  onPressed: () {
                    String requestData = urlController.text;
                    if (requestData.isNotEmpty) {
                      Map<String, dynamic> requestMap = {
                        'data': requestData,
                      };
                      abbrefyService
                          .makePostRequest(requestMap)
                          .then(_handleResponse);
                    } else {
                      print('Please enter the url');
                    }
                  },
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Developed by Eureka",
                    style: TextStyle(fontSize: 12, color: Colors.red),
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
