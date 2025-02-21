import "package:flutter/material.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";
import "package:geolocator/geolocator.dart";

import "dart:ui";
import "dart:convert";

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
    double latitude = 19.230128;
    double longitude = 72.970483;
    late Future<Map<String,dynamic>> weather;


    Future<void> getCoord() async
    {
        try
        {
            bool isEnabled = await Geolocator.isLocationServiceEnabled();

            if (!isEnabled)
            {
                return;
            }

            LocationPermission permission = await Geolocator.requestPermission();

            if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
            {
                return;
            }

            Position position = await Geolocator.getCurrentPosition(
                locationSettings: LocationSettings(
                    accuracy: LocationAccuracy.high,
                    distanceFilter: 100,
                ), 
            );

            latitude = position.latitude;
            longitude = position.longitude;
        }
        catch (e)
        {
            throw e.toString();
        }
    }


    Future<Map<String, dynamic>> getWeather() async
    {
        try
        {
            // const String city = "Mumbai";
            await getCoord();

            final String? apiKey = dotenv.env["API_KEY"];
            Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric");

            final res = await http.get(url);
            final data = jsonDecode(res.body);

            if (data["cod"] != "200")
            {
                throw "Server Error: Failed to fetch data.";
            }

            return data;   
        }
        catch (e)
        {
            debugPrint("${e.runtimeType}");
            throw e.toString();
        }
    }

    IconData getIcon(int skyId)
    {
        if (skyId >= 200 && skyId < 300)
        {
            return Icons.thunderstorm_rounded;
        }
        if (skyId >= 300 && skyId < 400)
        {
            return Icons.storm_rounded;
        }
        if (skyId >= 500 && skyId < 600)
        {
            return Icons.water_drop_sharp;
        }
        if (skyId >= 600 && skyId < 700)
        {
            return Icons.snowing;
        }
        if (skyId >= 700 && skyId < 800)
        {
            return Icons.air_sharp;
        }
        if (skyId == 800)
        {
            return Icons.sunny;
        }
        else
        {
            return Icons.cloud_circle_rounded;
        }
    }


    @override
    void initState()
    {
        super.initState();
        weather = getWeather();
    }


    @override
    Widget build (BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    "Weather Forecast",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                    ),
                ),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                            setState(() {
                                weather = getWeather();
                            });
                        },
                    ),
                    IconButton(
                        icon: widget.isDarkMode? const Icon(Icons.light_mode) : const Icon(Icons.dark_mode),
                        onPressed: () {
                            widget.toggleTheme();
                        },
                    )
                ],
            ),
            body: FutureBuilder(
                future: getWeather(),
                builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting)
                    {
                        return const Center(
                            child: CircularProgressIndicator.adaptive(),
                        );
                    }

                    if (snapshot.hasError)
                    {
                        return Center(
                            child: Text(
                                snapshot.error.toString(),
                            ),
                        );
                    }

                    final Map<String,dynamic> data = snapshot.data!;
                    
                    final double currTemp = data['list'][0]['main']['temp'];
                    final String currSky = data['list'][0]['weather'][0]['main'];
                    final int currSkyId = data['list'][0]['weather'][0]['id'];
                    final int currHumid = data['list'][0]['main']['humidity'];
                    final int currPress = data['list'][0]['main']['pressure'];
                    final double currWind = data['list'][0]['wind']['speed'];

                    return SingleChildScrollView(
                        clipBehavior: Clip.none,
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                        SizedBox(
                                            width: double.infinity,
                                            child: Card(
                                                elevation: 8,
                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35))),
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(35)),
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
                                                                        "$currTemp°C",
                                                                        style: const TextStyle(
                                                                            fontSize: 45,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: "Arial",
                                                                        ),
                                                                    ),
                                                                    const SizedBox(height: 12,),
                                                                    Icon(getIcon(currSkyId), size: 64,),
                                                                    const SizedBox(height: 15,),
                                                                    Text(
                                                                        currSky,
                                                                        style: const TextStyle(
                                                                            fontSize: 20,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontStyle: FontStyle.italic,
                                                                        ),
                                                                    ),
                                                                    const SizedBox(height: 6,),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ),
                                        const SizedBox(height: 38,),
                        
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "Hourly Forecast",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                        ),
                                        const SizedBox(height: 20,),
                        
                                        SizedBox(
                                            height: 140,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                clipBehavior: Clip.none,
                                                itemCount: 9,
                                                itemBuilder: (context, index) {
                                                    
                                                    final DateTime hourlyTime = DateTime.parse(data['list'][index + 1]['dt_txt']);
                                                    final int hourlySkyId = data['list'][index + 1]['weather'][0]['id'];
                                                    final double hourlyTemp = data['list'][index + 1]['main']['temp'];
                        
                                                    return HourlyForecastCard(
                                                        time: DateFormat('j').format(hourlyTime).toString(),
                                                        icon: getIcon(hourlySkyId),
                                                        temp: "$hourlyTemp°C",
                                                    );
                                                },
                                            ),
                                        ),
                                        
                                        // SingleChildScrollView(
                                        //     scrollDirection: Axis.horizontal,
                                        //     clipBehavior: Clip.none,
                                        //     child: Row(
                                        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //         children: [
                                        //             HourlyForecastCard(),
                                        //             HourlyForecastCard(),
                                        //             HourlyForecastCard(),
                                        //             HourlyForecastCard(),
                                        //         ],
                                        //     ),
                                        // ),
                                        const SizedBox(height: 38,),
                        
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "Additional Information",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                        ),
                                        const SizedBox(height: 18,),
                        
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                                MoreInfoCard(
                                                    icon: Icons.water_drop_rounded,
                                                    label: "Humidity",
                                                    value: "$currHumid %",
                                                ),
                                                MoreInfoCard(
                                                    icon: Icons.device_thermostat_rounded,
                                                    label: "Pressure",
                                                    value: "$currPress hPa", 
                                                ),
                                                MoreInfoCard(
                                                    icon: Icons.air_rounded,
                                                    label: "Wind Speed",
                                                    value: "$currWind m/s",
                                                ),
                                            ],
                                        )
                                    ],
                                ),
                            ),
                        ),
                    );
                },

            ),
        );
    }
}