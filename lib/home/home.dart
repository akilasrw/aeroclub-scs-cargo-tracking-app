import 'package:flutter/material.dart';
import 'package:Cargo_Tracker/pickup_cargo/pickup_cargo_main_details.dart';

class Home extends StatelessWidget{

  const Home({super.key});
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_){
                          return const PickUpCargoMainDetails();
                        }
                    ));
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