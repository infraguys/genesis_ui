import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/string_extension.dart';
import 'package:genesis/src/features/auth/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get isSignUpBtnEnabled {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final $ = context.$;

    return Scaffold(
      backgroundColor: Color(0xFF1B1B1D).hardcoded,
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text(
                  '${context.$.genesis} ${context.$.core}',
                  style: textTheme.headlineLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  controller: _usernameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'Username'.hardcoded),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.hardcoded;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _firstNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'First name'.hardcoded),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.hardcoded;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'Last name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.hardcoded;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'E-mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.hardcoded;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required'.hardcoded;
                    }
                    return null;
                  },
                ),
                ListenableBuilder(
                  listenable: Listenable.merge([
                    _firstNameController,
                    _lastNameController,
                    _emailController,
                    _passwordController,
                    _usernameController,
                  ]),
                  builder: (context, _) {
                    return ElevatedButton(
                      onPressed: isSignUpBtnEnabled ? () => signIn(context) : null,
                      child: Text($.signUp),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: context.pop,
                  child: Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final event = UserEvent.singUp(
        username: _usernameController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      context.read<UserBloc>().add(event);
    }
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final center = Offset(cx, cy);

    // Рисуем шестиугольник "вписанный" в круг радиуса outerR
    final outerR = min(size.width, size.height) * 0.45;
    final strokeWidth = outerR * 0.5;
    final innerR = outerR * 0.4;
    const sides = 6;

    // Вычисляем вершины правильного шестиугольника
    final points = List<Offset>.generate(sides, (i) {
      final angle = -pi / 2 + 2 * pi * i / sides;
      return center + Offset(cos(angle), sin(angle)) * outerR;
    });

    // Путь для шестиугольника
    final hexPath = Path()..addPolygon(points, true);

    // SweepGradient для плавного обтекания всего круга
    final shader = SweepGradient(
      startAngle: -pi / 2,
      endAngle: -pi / 2 + 2 * pi,
      colors: const [
        Color(0xFFFFD600), // жёлтый
        Color(0xFF00E676), // зелёный
        Color(0xFF2979FF), // синий
        Color(0xFF651FFF), // пурпурный
        Color(0xFFD50000), // красный
        Color(0xFFFFD600), // снова жёлтый для плавного замыкания
      ],
      stops: const [0, 0.2, 0.4, 0.6, 0.8, 1],
    ).createShader(Rect.fromCircle(center: center, radius: outerR));

    // Настройки краски для обводки
    final paintBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = shader
      ..strokeJoin = StrokeJoin
          .round // скруглённые стыки
      ..strokeCap = StrokeCap.round; // скруглённые концы линий

    canvas.drawPath(hexPath, paintBorder);

    // Центральный белый круг
    final paintCircle = Paint()..color = Colors.white;
    canvas.drawCircle(center, innerR, paintCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
