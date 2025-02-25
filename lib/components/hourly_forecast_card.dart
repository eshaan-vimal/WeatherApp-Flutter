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
                            const SizedBox(height: 12,),
                            Text(
                                time,
                                style: const TextStyle(
                                    fontSize: 18,
                                ),
                            ),
                            const SizedBox(height: 8,),
                            Icon(icon, size: 40,),
                            const SizedBox(height: 8,),
                            Text(
                                temp,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                ),
                            ),
                            const SizedBox(height: 12,),
                        ],
                    ),
                ),
            ),
        );
    }
}