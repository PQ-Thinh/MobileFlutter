import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:quocthinh_flutter_app/commercial_app/page_auth-user.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../my_widget/dialogs.dart';
import 'Page_Info_user.dart';

class PageVerifyOtp extends StatelessWidget {
  String? email;
  PageVerifyOtp({super.key, required String email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác thực mã OTP"),
      ),
      body: Column(
        children: [
          OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFF512DA8),
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) async {
                response = await Supabase.instance.client.auth.verifyOTP(
                    type: OtpType.email, token: verificationCode, email: email);

                if (response?.session != null && response?.user != null) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => PageUserInfo(),
                      ),
                          (route) => false);
                }
              }),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () async {
                showSnackBar(context, message: "Đang gửi mã OTP", seconds: 600);

                final response = await Supabase.instance.client.auth
                    .signInWithOtp(email: email);

                showSnackBar(context, message: "Mã OTP đã được gửi");
              },
              child: Text("Gửi lại mã OTP"))
        ],
      ),
    );
  }
}
