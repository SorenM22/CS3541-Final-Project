import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_ctrl_alt_defeat/Model/authentication_repository.dart';
import 'package:final_ctrl_alt_defeat/Presenter/csv_reader.dart';
import 'package:final_ctrl_alt_defeat/Presenter/search_bar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Model/destination.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:final_ctrl_alt_defeat/Presenter/profile_avatar_icon_presenter.dart';

import '../Model/image_model.dart';
import '../Model/user_repository.dart';
import '../Presenter/image_presenter.dart';


class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final user = Get.put(UserRepository());
  final db = FirebaseFirestore.instance.collection("User_Data");

  late ImagePickerPresenter presenter;
  String selectedImagePath = 'Assets/bridgeTest2.jpg';
  final auth = Get.put(AuthenticationRepository());
  final SearchBarPresenter searchBarPresenter = Get.put(SearchBarPresenter());
  final AudioPlayer _audioPlayer = AudioPlayer();
  late Uint8List audioBytes;
  bool isPlaying = false;
  final reader = csv_reader();
  final profileController = Get.find<ProfileController>();

  void navToHome() => Get.toNamed(Destination.home.route, id: 1);
  void navToGoals() => Get.toNamed(Destination.goals.route, id: 1);
  void navToCalendar() => Get.toNamed(Destination.calendar.route, id: 1);
  void navToSettings() => Get.toNamed(Destination.settings.route, id: 1);
  void navToSearchListings() {
    searchBarPresenter.activeSuggestionsType = SuggestionType.jobsTitle;
    Get.toNamed(Destination.searchListings.route, id: 1);
  }
  void navToCompareListings() => Get.toNamed(Destination.compareListings.route, id: 1);
  void navToSearchTrends() {
    searchBarPresenter.activeSuggestionsType = SuggestionType.workSetting;
    Get.toNamed(Destination.searchTrends.route, id: 1);
  }
  void navToCompareTrends() {
    searchBarPresenter.activeSuggestionsType = SuggestionType.trendsCategory;
    Get.toNamed(Destination.compareTrends.route, id: 1);
  }


  void initState() {
    super.initState();
    presenter = ImagePickerPresenter(ImageModel());
    presenter.selectedImagePathNotifier.addListener(updateSelectedImage);

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
  void updateSelectedImage() {
    setState(() {
      selectedImagePath = presenter.selectedImagePathNotifier.value;
    });
  }
  void showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a Profile Picture'),
          content: SingleChildScrollView(
            child: Column(
              children: presenter.getImageOptions(context, () {
                Navigator.of(context).pop();
              }),
            ),
          ),
        );
      },
    );
  }
  @override
  void dispose() {
    _audioPlayer.dispose();
    presenter.selectedImagePathNotifier.removeListener(updateSelectedImage);
    super.dispose();
  }
  final String imagePath = r"C:\Users\ajcar\OneDrive\Pictures\bridgeTest.jpg";

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
              color: Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).colorScheme.primary,
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
            SizedBox(width: 16),
            MenuAnchor(
                menuChildren: [
                  MenuItemButton(
                    onPressed: navToSearchTrends,
                    child: const Text('Search'),
                  ),
                  MenuItemButton(
                    onPressed: navToCompareTrends,
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
                      icon: Icon(Icons.trending_up),
                      label: const Text("Trends"),
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary)
                  );
                }
            )]
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Home"),
              onTap: () {
                navToHome();
                Navigator.of(context).pop(); // Close the drawer
              },
            ),
            ListTile(
              title: Text("Goals"),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                navToGoals();
              },
            ),
            ListTile(
              title: Text("Calendar"),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                navToCalendar();
              },
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
              child: Row(
                children: [
                  GestureDetector(
                    onTap: showImagePickerDialog,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(selectedImagePath),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      profileController.profileInitial.value,
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
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
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                navToSettings();
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sign Out"),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                auth.signout(); // Keeps the logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
