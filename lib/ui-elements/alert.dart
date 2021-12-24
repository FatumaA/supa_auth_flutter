import 'package:flutter/material.dart';
import 'package:supa_auth_flutter/utils/supabase.dart';

class AlertUI extends StatefulWidget {
  String headerText, bodyText, closeAlertBtnText;
  String? phone;

  AlertUI(
      {Key? key,
      required this.headerText,
      required this.bodyText,
      required this.closeAlertBtnText,
      this.phone})
      : super(key: key);

  @override
  State<AlertUI> createState() => _AlertUIState();
}

class _AlertUIState extends State<AlertUI> {
  final _formKey = GlobalKey<FormState>();
  final _token = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _token.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.grey[800],
      title: Text(
        widget.headerText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white70,
        ),
      ),
      content: widget.headerText == 'Enter your verification code'
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Entered the wrong verification code';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      prefixStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(),
                      hintText: 'Enter your verfification code',
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    controller: _token,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await SupabaseHelper()
                                .verifyPhoneUser(widget.phone!, _token.text);
                            _token.text = '';
                            Navigator.pop(context);
                          } catch (e) {
                            throw Exception(e.toString());
                          }
                        }
                      },
                      child: const Text(
                        'Verify',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Text(
              widget.bodyText,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            widget.closeAlertBtnText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
