import 'package:flutter/material.dart';
import 'package:flutter_app/providers/home_view_model.dart';
import 'package:flutter_app/views/homeview.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: MaterialApp(
        title: 'Takehome Interview',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Homeview(),
      ),
    );
  }
}
