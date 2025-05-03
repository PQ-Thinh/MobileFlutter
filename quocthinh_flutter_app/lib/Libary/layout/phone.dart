import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Pagephone extends StatelessWidget {
  Pagephone({super.key});
  final TextEditingController txtPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY Phone"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: txtPhone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final res = await showConfirmDialog(context, "Bạn có muốn cấp quyền gọi điện không?");
                      if (res == "ok") {
                        openPhoneDial(txtPhone.text);
                      }
                    },
                    child: const Text("Cấp quyền"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      openPhoneDial(txtPhone.text);
                    },
                    child: const Text("Gọi"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> openPhoneDial(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await launchUrl(uri)) {
      return true;
    } else {
      Get.snackbar("Lỗi", "Không thể mở trình quay số",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<String?> showConfirmDialog(BuildContext context, String dispMessage) async {
    AlertDialog dialog = AlertDialog(
      title: const Text("Xác nhận"),
      content: Text(dispMessage),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop("cancel"),
          child: const Text("Hủy"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok"),
          child: const Text("OK"),
        ),
      ],
    );
    String? res = await showDialog<String?>(
      barrierDismissible: false,
      context: context,
      builder: (context) => dialog,
    );
    return res;
  }
}
