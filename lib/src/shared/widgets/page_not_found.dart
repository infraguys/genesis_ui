import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:go_router/go_router.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final $ = context.$;

    return Scaffold(
      backgroundColor: Color(0xFF191919).hardcoded,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 340),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 34,
            children: [
              Text(
                '404',
                style: TextStyle(
                  fontSize: 200,
                  color: Color(0XFFB3B2B0).hardcoded,
                  fontWeight: FontWeight.bold,
                  height: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  $.pageNotFound,
                  style: TextStyle(fontSize: 40, color: Color(0XFFB3B2B0).hardcoded),
                  textAlign: TextAlign.center,
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
                    EdgeInsets.symmetric(vertical: 24),
                  ),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Color(0xFF2E2E2E).hardcoded),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: Text($.goBack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
