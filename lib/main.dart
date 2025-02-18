import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

import "./screens/home_screen.dart";


void main() async
{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");

    runApp(const MyApp());
}


class MyApp extends StatefulWidget
{
    const MyApp ({super.key});

    @override
    State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp>
{
    bool isDarkMode = true;


    void toggleTheme ()
    {
        setState(() {
            isDarkMode = !isDarkMode;
        });
    }

    @override
    Widget build (BuildContext context)
    {
        return MaterialApp(
            title: "eV Weather",
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: isDarkMode? ThemeMode.dark : ThemeMode.light,
            home: HomeScreen(isDarkMode: isDarkMode, toggleTheme: toggleTheme,),
            debugShowCheckedModeBanner: false,
        );
    }
}