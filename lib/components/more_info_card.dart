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
                    const SizedBox(height: 12,),
                    Icon(icon, size: 40,),
                    const SizedBox(height: 10,),
                    Text(
                        label,
                        style: const TextStyle(
                            fontSize: 18,
                        ),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                        value,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                        ),
                    ),
                    const SizedBox(height: 12,),
                ],
            ),
        );
    }
}