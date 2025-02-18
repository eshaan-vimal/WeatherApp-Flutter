import "package:flutter/material.dart";


class HourlyForecastCard extends StatelessWidget
{
    const HourlyForecastCard ({super.key});

    @override
    Widget build (BuildContext context)
    {
        return SizedBox(
            width: 120,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Card(
                    elevation: 6,
                    child: Column(
                        children: [
                            SizedBox(height: 12,),
                            Text(
                                "12 PM",
                                style: TextStyle(
                                    fontSize: 18,
                                ),
                            ),
                            SizedBox(height: 8,),
                            Icon(Icons.cloud, size: 40,),
                            SizedBox(height: 8,),
                            Text(
                                "Clouds",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                ),
                            ),
                            SizedBox(height: 12,),
                        ],
                    ),
                ),
            ),
        );
    }
}