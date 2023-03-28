import 'package:code_fac/common/component/custom_text_form_field.dart';
import 'package:code_fac/common/layout/deafult_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: "이메일을 입력해주세요",
              onChanged: (value) {},
            ),
            CustomTextFormField(
              hintText: "비밀번호를 입력해주세요",
              onChanged: (value) {},
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다!",
      style: TextStyle(fontSize: 34),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
