import 'package:flutter/material.dart';
import 'package:quocthinh_flutter_app/commercial_app/page_verify_OTP.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

AuthResponse? response;

class PageFruitStoreLogin extends StatelessWidget {
  const PageFruitStoreLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: Container()),
              SupaEmailAuth(
                onSignInComplete: (res) {
                  response = res;
                  Navigator.of(context).pop();
                },
                onSignUpComplete: (res) {
                  if (res.user != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PageVerifyOtp(
                        email: res.user!.email!,
                      ),
                    ));
                  }
                },
                showConfirmPasswordField: true,
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
