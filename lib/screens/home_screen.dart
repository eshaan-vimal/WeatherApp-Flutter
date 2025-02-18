import "package:flutter/material.dart";


class HomeScreen extends StatefulWidget
{
    final bool isDarkMode;
    final Function toggleTheme;

    const HomeScreen ({
        super.key,
        required this.isDarkMode,
        required this.toggleTheme,
    });

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
{
    @override
    void initState()
    {
        super.initState();

    }


    @override
    Widget build (BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    "Weather Forecast",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                actions: [
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {

                        },
                    ),
                    IconButton(
                        icon: widget.isDarkMode? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
                        onPressed: () {
                            widget.toggleTheme();
                        },
                    )
                ],
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Placeholder(fallbackWidth: 120, fallbackHeight: 100,),
                        SizedBox(height: 20,),
                        Placeholder()
                    ],
                ),
            ),
        );
    }
}