import "package:flutter/material.dart";


class HourlyForecastCard extends StatelessWidget
{
    final String time;
    final IconData icon;
    final String temp;

    const HourlyForecastCard ({
        super.key,
        required this.time,
        required this.icon,
        required this.temp,
    });

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
                                time,
                                style: TextStyle(
                                    fontSize: 18,
                                ),
                            ),
                            SizedBox(height: 8,),
                            Icon(icon, size: 40,),
                            SizedBox(height: 8,),
                            Text(
                                temp,
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