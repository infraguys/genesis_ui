import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:go_router/go_router.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191919).hardcoded,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .stretch,
            spacing: 34,
            children: [
              Text(
                '404',
                style: TextStyle(
                  fontSize: 200,
                  color: Color(0XFFB3B2B0).hardcoded,
                  fontWeight: .bold,
                  height: 0.8,
                ),
                textAlign: .center,
              ),
              FittedBox(
                fit: .scaleDown,
                child: Text(
                  context.$.pageNotFound,
                  style: TextStyle(fontSize: 40, color: Color(0XFFB3B2B0).hardcoded),
                  textAlign: .center,
                ),
              ),
              ElevatedButton(
                onPressed: context.pop,
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF1E1E1E).hardcoded),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(fontSize: 24),
                  ),
                  padding: WidgetStatePropertyAll(
                    .symmetric(vertical: 18),
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Color(0xFF2E2E2E).hardcoded),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: .circular(16)),
                  ),
                ),
                child: Text(context.$.goBack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
