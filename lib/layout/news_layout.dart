import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getScience()
        ..getSports(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return BlocBuilder<AppCubit, AppStates>(
            builder: (context, appState) {
              print('hello');
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: SearchScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.brightness_4_outlined),
                      onPressed: () {
                        AppCubit.get(context).changeAppMode();
                      },
                    ),
                  ],
                  title: Text('News App'),
                ),
                body: cubit.listScreens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: bottomItem,
                  currentIndex: cubit.currentIndex,
                  onTap: (value) {
                    cubit.changeBottomNav(value);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports_outlined),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Science',
    ),
  ];
}
