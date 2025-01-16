import 'dart:io';

import 'package:e_commerce/hive/hive_registrar.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';


import 'bloc/Product/index.dart';
import 'bloc/cart/index.dart';
import 'bloc/home/index.dart';
import 'views/Splashscreen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive..init(appDocumentDirectory.path)..registerAdapters();

  

   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(
            create: (context) => ProductBloc(
                   const UnProductState(),
                )),
        BlocProvider(
            create: (context) => HomeBloc(
                  const UnHomeState(),
                )),
                BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(const UnHomeState())
            ..add(LoadHomeEvent(indexCategory: 0, Category: "All")),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(const UnProductState())
            ..add(LoadProductEvent(category: "All")),
        ),
         BlocProvider<CartBloc>(
          
          create: (context) => CartBloc(const UnCartState())..add(LoadCartEvent(userId: 1)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
