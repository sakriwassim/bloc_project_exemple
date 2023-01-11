import 'package:block_breakingbad_flutter/business_logic/cubit/characters_cubit.dart';
import 'package:block_breakingbad_flutter/constants/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;

  @override
  void initState() {
    allCharacters =
        BlocProvider.of<CharactersCubit>(context).GetAllCharacters();
    super.initState();
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return Container(
      color: MyColors.myGrey,
      child: Column(
        children: [
          buildCharactersList(),
        ],
      ),
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildCharactersList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: allCharacters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allCharacters[index].fullName.toString()),
          );
        });
  }

  // Widget buildCharactersList() {
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       childAspectRatio: 2 / 3,
  //       crossAxisSpacing: 1,
  //       mainAxisSpacing: 1,
  //     ),
  //     shrinkWrap: true,
  //     physics: const ClampingScrollPhysics(),
  //     padding: EdgeInsets.zero,
  //     // itemCount: _searchTextController.text.isEmpty
  //     //     ? allCharacters.length
  //     //     : searchedForCharacters.length,
  //     itemBuilder: (ctx, index) {
  //       return CharacterItem(
  //         character: allCharacters[index],
  //       );
  //       // (
  //       // character: _searchTextController.text.isEmpty
  //       //     ? allCharacters[index]
  //       //     : searchedForCharacters[index],
  //       // );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: Text("Characters", style: TextStyle(color: MyColors.myGrey)),
      ),
      body: buildBlockWidget(),
    );
  }
}
