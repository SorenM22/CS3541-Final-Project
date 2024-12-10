import 'dart:typed_data';

import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Presenter/csv_reader.dart';
import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Model/destination.dart';
import 'package:audioplayers/audioplayers.dart';


class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final auth = Get.put(AuthenticationRepository());
  final SearchBarPresenter searchBarPresenter = Get.put(SearchBarPresenter());
  final AudioPlayer _audioPlayer = AudioPlayer();
  late Uint8List audioBytes;
  bool isPlaying = false;
  final reader = csv_reader();

  void navToHome() => Get.toNamed(Destination.home.route, id: 1);
  void navToGoals() => Get.toNamed(Destination.goals.route, id: 1);
  void navToCalendar() => Get.toNamed(Destination.calendar.route, id: 1);
  void navToSettings() => Get.toNamed(Destination.settings.route, id: 1);
  void navToSearchListings() {
    searchBarPresenter.activeSuggestionsType = SuggestionType.jobsTitle;
    Get.toNamed(Destination.searchListings.route, id: 1);
  }
  void navToCompareListings() => Get.toNamed(Destination.compareListings.route, id: 1);
  void navToTrends() {
    searchBarPresenter.activeSuggestionsType = SuggestionType.trendsCategory;
    Get.toNamed(Destination.trends.route, id: 1);
  }


  void initState() {
    super.initState();


    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
  }

  Future<void> loadAudio(String assetPath) async {
    ByteData bytes = await rootBundle.load(assetPath);
    audioBytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> playMusic(String assetPath) async {
    await loadAudio(assetPath);
    //await _audioPlayer.stop();
    if (_audioPlayer.state == PlayerState.playing){
      await  _audioPlayer.pause();
      isPlaying = false;
    }
    else{
      await  _audioPlayer.play(BytesSource(audioBytes));
      isPlaying = true;
    }

  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: const Text('Base Page'),
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: Scaffold.of(context).openDrawer,
              icon: const Icon(Icons.menu),
              color: Colors.white,
            );
          }),
          actions: <Widget>[
            SizedBox(
              width: 300,
              height: 45,
              child: SearchAnchor(
                searchController: searchBarPresenter.searchBarController,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    leading: const Icon(Icons.search),
                    controller: controller,
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) async {
                  List<String> suggestions = await searchBarPresenter.getActiveSuggestions(controller.text,context);
                  return List<ListTile>.generate(suggestions.length, (int index) {
                    final String item = suggestions[index];
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    );
                  });
                },
              ),
            ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: Scaffold.of(context).openEndDrawer,
                icon: const Icon(Icons.person),
                color: Colors.white,
              );
            }),
          ]
      ),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Destination.home.route,
        onGenerateRoute: (settings) => Destination.getPage(settings),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuAnchor(
              menuChildren: [
                  MenuItemButton(
                    onPressed: navToSearchListings,
                    child: const Text('Search'),
                  ),
                MenuItemButton(
                  onPressed: navToCompareListings,
                  child: const Text("Compare"),
                )
                ],
              builder: (context, controller, child) {
                return TextButton.icon(
                    onPressed: () {
                      if(controller.isOpen) {
                        controller.close();
                      } else {
                        controller.open();
                      }
                    },
                    icon: Icon(Icons.list),
                    label: const Text("Listings"),
                    style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
                );
              }
            ),
            TextButton.icon(
                onPressed: navToTrends,
                icon: Icon(Icons.trending_up),
                label: const Text("Trends"),
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Home"),
              onTap: navToHome,
            ),
            ListTile(
              title: Text("Goals"),
              onTap: navToGoals,
            ),
            ListTile(
              title: Text("Calendar"),
              onTap: navToCalendar,
            ),
            ListTile(
              title: Row(
                children: [
                  Text("Calming Music"),
                  SizedBox(width: 8),
                  Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                ],
              ),
              onTap: (){playMusic('Assets/Aylex - Meditation.mp3');}
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: navToSettings
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
              onTap: auth.signout, // Keeps the logout functionality
            ),
          ],
        ),
      ),
    );
  }
}
