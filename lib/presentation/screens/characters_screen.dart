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
  List<Character> allCharacters = [];

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
      child: buildCharactersList(),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: allCharacters.length,
        itemBuilder: (BuildContext ctx, index) {
          return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
              child: CharacterItem(
                character: allCharacters[index],
              )

              // Text(allCharacters[index].firstName.toString()),
              );
        });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

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
