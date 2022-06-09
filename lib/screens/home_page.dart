import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:weather/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/resources/app_color.dart';
import 'package:weather/shared/components/app_loading.dart';
import 'package:weather/shared/components/snack_bar.dart';
import 'package:weather/shared/components/text_display.dart';
import 'package:weather/shared/local/cache_helper.dart';

class HomePage extends StatefulWidget {
  final Coord coord;
  const HomePage({Key? key, required this.coord}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherBloc weatherBloc = WeatherBloc();
  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();
    try {
      CacheHelper.getStoredWeatherInfo().then((value) {
        setState(() {
          weatherModel = value;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: AppTextDisplay(
        text: 'Weather Logger',
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      )),
      bottomSheet:
          RequestWeatherButton(weatherBloc: weatherBloc, coord: widget.coord),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocProvider<WeatherBloc>.value(
                value: weatherBloc,
                child: BlocConsumer<WeatherBloc, WeatherState>(
                  listener: (BuildContext context, WeatherState state) {
                    if (state is WeatherFailedState) {
                      showSnackBar(context: context, message: state.error);
                    } else if (state is ConnectionError) {
                      showSnackBar(
                          context: context, message: "Connection Error");
                    }
                  },
                  builder: (BuildContext context, WeatherState state) {
                    if (state is WeatherLoadingState) {
                      return const LoadingWidget();
                    } else if (state is WeatherSuccessState) {
                      return CentredAlignedCard(
                          weatherModel: state.weatherModel);
                    }
                    return weatherModel != null
                        ? Column(
                            children: [
                              CentredAlignedCard(weatherModel: weatherModel!),
                              SizedBox(
                                height: 20.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: AppTextDisplay(
                                  text:
                                      'This is your last requested weather info, please click on GET WEATHER button to get weather info of your current city',
                                  softWrap: false,
                                  maxLines: 4,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.chambray,
                                ),
                              )
                            ],
                          )
                        : AppTextDisplay(
                            text: 'Request Current City Weather Info',
                            softWrap: true,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.chambray,
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestWeatherButton extends StatelessWidget {
  const RequestWeatherButton(
      {Key? key, required this.weatherBloc, required this.coord})
      : super(key: key);

  final WeatherBloc weatherBloc;
  final Coord coord;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: ElevatedButton(
              onPressed: () async {
                // Coord coord = await _getCurrentLocation();
                weatherBloc.add(GetCurrentWeatherEvent(location: coord));
              },
              child: AppTextDisplay(
                text: 'Get Weather',
                fontSize: 10.sp,
                color: AppColors.white,
              )),
        ),
      ],
    );
  }
}

class CentredAlignedCard extends StatefulWidget {
  final WeatherModel weatherModel;

  const CentredAlignedCard({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  @override
  State<CentredAlignedCard> createState() => _CentredAlignedCardState();
}

class _CentredAlignedCardState extends State<CentredAlignedCard> {
  late bool showAllWeatherInfo = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290.w,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.doveGray.withOpacity(0.17),
              blurRadius: 15.0.r,
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CardItem(
                    title: 'Temperature:  ',
                    text: widget.weatherModel.main!.temp!.toString() +
                        ' Celsius'),
                SizedBox(height: 7.h),
                CardItem(
                    title: 'Date:  ',
                    text: DateFormat('EEE d MMM')
                        .format(widget.weatherModel.main!.date!)),
                SizedBox(
                  height: 10.h,
                ),
                if (!showAllWeatherInfo)
                  buildMaximizeAndMinimizeRow('Read More'),
                if (showAllWeatherInfo) ...[
                  CardItem(
                      title: 'Feels like:  ',
                      text: widget.weatherModel.main!.feelsLike.toString()),
                  SizedBox(height: 7.h),
                  CardItem(
                      title: 'Temp min:  ',
                      text: widget.weatherModel.main!.tempMin.toString()),
                  SizedBox(height: 7.h),
                  CardItem(
                      title: 'Temp max:  ',
                      text: widget.weatherModel.main!.tempMax.toString()),
                  SizedBox(height: 7.h),
                  CardItem(
                      title: 'Pressure:  ',
                      text: widget.weatherModel.main!.pressure.toString()),
                  SizedBox(height: 7.h),
                  CardItem(
                      title: 'Humidity:  ',
                      text: widget.weatherModel.main!.humidity.toString()),
                  SizedBox(height: 7.h),
                  buildMaximizeAndMinimizeRow('Read Less'),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildMaximizeAndMinimizeRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
            onTap: () =>
                setState(() => showAllWeatherInfo = !showAllWeatherInfo),
            child: AppTextDisplay(
                text: text, fontSize: 7.sp, color: AppColors.grayDark)),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppTextDisplay(
          text: title,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        AppTextDisplay(
          text: text,
          softWrap: true,
          fontSize: 8.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.facebookColor,
        ),
      ],
    );
  }
}
