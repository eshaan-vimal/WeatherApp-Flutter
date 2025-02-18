import "package:flutter/material.dart";
import "dart:ui";

import "../components/hourly_forecast_card.dart";
import "../components/more_info_card.dart";


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
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            SizedBox(
                                width: double.infinity,
                                child: Card(
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35))),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(35)),
                                        child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10,
                                                sigmaY: 10,
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.all(18.0),
                                                child: Column(
                                                    children: [
                                                        Text(
                                                            "300 K",
                                                            style: TextStyle(
                                                                fontSize: 45,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: "Arial",
                                                            ),
                                                        ),
                                                        Icon(Icons.cloud, size: 64,),
                                                        SizedBox(height: 8,),
                                                        Text(
                                                            "Rain",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w500,
                                                                fontStyle: FontStyle.italic,
                                                            ),
                                                        ),
                                                        SizedBox(height: 6,),
                                                    ],
                                                ),
                                            ),
                                        ),
                                    ),
                                ),
                            ),
                            SizedBox(height: 38,),

                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Hourly Forecast",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ),
                            SizedBox(height: 20,),
                            
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                clipBehavior: Clip.none,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                        HourlyForecastCard(),
                                        HourlyForecastCard(),
                                        HourlyForecastCard(),
                                        HourlyForecastCard(),
                                    ],
                                ),
                            ),
                            SizedBox(height: 38,),

                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Additional Information",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ),
                            SizedBox(height: 18,),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                    MoreInfoCard(
                                        icon: Icons.water_drop_rounded,
                                        label: "Humidity",
                                        value: "87%",
                                    ),
                                    MoreInfoCard(
                                        icon: Icons.device_thermostat_rounded,
                                        label: "Pressure",
                                        value: "90", 
                                    ),
                                    MoreInfoCard(
                                        icon: Icons.air_rounded,
                                        label: "Wind Speed",
                                        value: "80",
                                    ),
                                ],
                            )
                        ],
                    ),
                ),
            ),
        );
    }
}