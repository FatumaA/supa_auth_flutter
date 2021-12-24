import 'package:flutter/material.dart';

class OtherProviders extends StatefulWidget {
  const OtherProviders({Key? key}) : super(key: key);

  @override
  _OtherProvidersState createState() => _OtherProvidersState();
}

class _OtherProvidersState extends State<OtherProviders> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Or...',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 4.5,
            crossAxisSpacing: 20,
            shrinkWrap: true,
            children: [
              ElevatedButton(
                // style: const ButtonStyle(
                //   backgroundColor: Colors.red.shade500,
                // ),
                onPressed: () {},
                child: const Text(
                  'Sign in With Google',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Sign in With Phone',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Passwordless Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
