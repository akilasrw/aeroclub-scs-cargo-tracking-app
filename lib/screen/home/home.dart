import 'package:Cargo_Tracker/router/router.gr.dart';
import 'package:Cargo_Tracker/screen/pickup_cargo/pickup_cargo_main_details.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget{

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  onPressed: () {
                    context.router.push(const PickUpCargoMainDetailsRoute());
                  },
                  child: const Text(
                    'Pick up Cargo',
                    style: TextStyle(fontSize: 24,color: Colors.black),
                  )
              ),
              const SizedBox(
                height: 30,
              ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          onPressed: () {},
          child: const Text(
            'Handover Cargo',
            style: TextStyle(fontSize: 24,color: Colors.black),
          )
        )
            ],
          ),
        ),
      )
    );
  }

}