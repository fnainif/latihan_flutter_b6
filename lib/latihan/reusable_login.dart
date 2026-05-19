import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.hint, required this.icon});

  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color.fromARGB(150, 217, 217, 217)),
          hintText: hint,
          hintStyle: TextStyle(color: Color.fromARGB(150, 217, 217, 217)),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(50, 156, 155, 155),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class SocmedButton extends StatelessWidget {
  const SocmedButton({
    super.key,
    required this.sosmed,
    required this.warnaBox,
    this.loginSize = 16,
  });

  final String sosmed;
  final Color warnaBox;
  final double loginSize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print("menuju $sosmed");
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: warnaBox,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            sosmed,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 217, 217, 217),
              fontSize: loginSize,
            ),
          ),
        ),
      ),
    );
  }
}
