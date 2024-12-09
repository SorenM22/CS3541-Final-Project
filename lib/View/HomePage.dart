import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/HomePageController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = Get.put(HomePageController());

  List<Widget> items = [];

  Future<void> retrieveData() async {
    /*for (var workout in await *//*needs to get size of dataset*//*) {
      items.add(*//* Needs to put item inside *//*);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => FutureBuilder(
        future: retrieveData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return controller.listingsPicked.value ? Scaffold(
                appBar: AppBar(
                  title: Text("Listings"
                  ),
                ),
                body: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        child: ListTile(
                          title: items[index],
                        )
                    );
                  },
                )
            ) :
            Scaffold(
              appBar: AppBar(
                title: Text("Trends"
                ),
              ),
              body: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      child: ListTile(
                        title: items[index],
                      )
                  );
                },
              )
            );
          } //end of if
          return const Text("Loading");
        }
      ),
    );
  }
}

class JobItem extends StatefulWidget {
  const JobItem({super.key, required this.id});
  final String id;

  @override
  State<JobItem> createState() {
    return _JobItemState();
  }
}

class _JobItemState extends State<JobItem> {
  String getId() {
    return widget.id;
  }

  // Delete this I just want to push this
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

/*
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Flexible(
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: Text(
                            style: const TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                            "Workout: ${truncateString(getId())}")),
                    IconButton(
                        onPressed: deleteExercise,
                        icon: Icon(
                            color: Theme.of(context).colorScheme.onSecondary,
                            CupertinoIcons.trash_circle,
                            size: 30)),
                  ]),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: Theme.of(context).colorScheme.onSecondary),
                    shrinkWrap: true,
                    itemCount: exerciseList.length,
                    itemBuilder: (context, index) {
                      return ExerciseItem(
                          id: getId(), exercise: exerciseList[index]);
                    },
                  )
                ])
            );
          }
          return const Text("Loading");
        });
  }*/
}
