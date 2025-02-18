import "package:flutter/material.dart";


class MoreInfoCard extends StatelessWidget
{
    final IconData icon;
    final String label;
    final String value;

    const MoreInfoCard ({
        super.key,
        required this.icon,
        required this.label,
        required this.value,
    });

    @override
    Widget build (BuildContext context)
    {
        return SizedBox(
            width: 120,
            child: Column(
                children: [
                    SizedBox(height: 12,),
                    Icon(icon, size: 40,),
                    SizedBox(height: 10,),
                    Text(
                        label,
                        style: TextStyle(
                            fontSize: 18,
                        ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                        value,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                    ),
                    SizedBox(height: 12,),
                ],
            ),
        );
    }
}