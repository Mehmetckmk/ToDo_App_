import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/hive_data_store.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/views/home/home_view.dart';
import 'package:to_do_app/views/slider_buton/profile_page.dart';
import 'package:to_do_app/views/tasks/task_view.dart';

Future<void>main()async{
  ///Init Hive DB Before runnApp
  await Hive.initFlutter();

  ///Register Hive Adapter
  Hive.registerAdapter<Task>(TaskAdapter());


  ///Open a Box
  Box box=await Hive.openBox<Task>(HiveDataStore.boxName);


  ///Otomatik olarak bugün olmayan görevleri siler
  box.values.forEach(
          (task) {
        if(task.createdAtTime.day!=DateTime.now())
        {task.delete();
        }else{
          ///Do Nothing
        }
      }
  );

  runApp(BaseWidget(child: const MyApp()));
}


class BaseWidget extends InheritedWidget{
  BaseWidget({Key? key,required this.child}):super(key:key,child: child);
  final HiveDataStore dataStore=HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context){
    final base=context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if(base!=null){
      return base;
    }else{
      throw StateError("Could not find ancestor widget of type BaseWidget");
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontFamily: "Libre"
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
              fontFamily: "Libre"
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
              fontFamily: "Libre"
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
              fontFamily: "Libre"
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
              fontFamily: "Libre"
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
              fontFamily: "Libre"
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
              fontFamily: "Libre"
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
              fontFamily: "Libre"
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}