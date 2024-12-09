import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Model/session_data.dart';
import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Model/destination.dart';
import 'package:audioplayers/audioplayers.dart';
import '../Model/HomePageController.dart';


class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final auth = Get.put(AuthenticationRepository());
  final SearchBarPresenter searchBarPresenter = Get.put(SearchBarPresenter());
  final AudioPlayer _audioPlayer = AudioPlayer();
  final HomePageController homePageController = Get.put(HomePageController());
  bool isPlaying = false;

  void navToHome() => Get.toNamed(Destination.home.route, id: 1);
  void navToGoals() => Get.toNamed(Destination.goals.route, id: 1);
  void navToCalendar() => Get.toNamed(Destination.calendar.route, id: 1);

  void changeToListings() {
    var sessionData = SessionData();
    sessionData.searchContent = SearchContent.listings;
    homePageController.toggleListings(true); // Set to Listings
  }

  void changeToTrends() {
    var sessionData = SessionData();
    sessionData.searchContent = SearchContent.trends;
    homePageController.toggleListings(false); // Set to Trends
  }

  void toggleSound() {
    setState(() {
      if (isPlaying) {
        // Pause the sound
        pauseSound();
      } else {
        // Play the sound
        playSound();
      }
      isPlaying = !isPlaying;
    });
  }

  void playSound() async {
    await _audioPlayer.play(AssetSource('Assets/Aylex - Meditation.mp3')); // Play local file
  }

  void pauseSound() async {
    await _audioPlayer.pause(); // Pause sound
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: const Text('Home Page'),
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
            IconButton(
              onPressed: auth.signout,
              icon: const Icon(Icons.person),
              color: Colors.white,
            ),
          ]),
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Destination.home.route,
        onGenerateRoute: (settings) => Destination.getPage(settings),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: changeToListings,
              icon: Icon(Icons.list),
              label: const Text("Listings"),
              style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
            ),
            TextButton.icon(
                onPressed: changeToTrends,
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
              onTap: toggleSound,
            )
          ],
        ),
      ),
    );
  }
}
