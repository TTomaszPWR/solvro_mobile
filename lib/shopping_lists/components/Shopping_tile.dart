import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solvro_basket_buddy/auth/components/auth_button.dart';
import 'package:solvro_basket_buddy/auth/components/auth_text_field.dart';
import 'package:solvro_basket_buddy/shopping_lists/bloc/shopping_lists_bloc.dart';
import 'package:solvro_basket_buddy/shopping_lists/components/color_buttons.dart';
import 'package:solvro_basket_buddy/shopping_lists/components/more_options_tile.dart';

class ShoppingTile extends StatelessWidget {
  final int index;
  final TextEditingController changeNameController = TextEditingController();
  final List<bool> _selections = List.generate(3, (_) => false);


  ShoppingTile({super.key, required this.index});

  Color getColor(String color, int shade) {
    switch (color) {
      case 'red':
        return Colors.red[shade]!;
      case 'blue':
        return Colors.blue[shade]!;
      case 'orange':
        return Colors.orange[shade]!;
      default:
        return Colors.grey[shade]!;
    }
  }

  String getStringColor(){
    for(int i=0;i<_selections.length; i++){
      if(_selections[i]){
        switch(i){
          case 0 : return "red";
          case 1 : return "blue";
          case 2 : return "orange";
        }
      }
    }
    throw Error();
  }

  void moreOptions(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.grey[300],
      context: context,
      builder: (context) {
        return Wrap(
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
            
                MoreOptionsTile(
                  text: 'Zmień nazwę', 
                  color: Colors.grey[800], 
                  icon: Icons.draw, 
                  onTap:() => changeName(context)
                ),
                MoreOptionsTile(
                  text: 'Zmień kolor', 
                  color: Colors.grey[800], 
                  icon: Icons.color_lens, 
                  onTap: () => changeColor(context)
                ),
                MoreOptionsTile(
                  text: 'Usuń listę', 
                  color: Colors.red, 
                  icon: Icons.delete, 
                  onTap: deleteList
                ),
              ],
            ),
          ),]
        );
      },
    );
  }

  void changeName(BuildContext context){
    Navigator.pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.grey[300],
      context: context,
      builder: (context) {
        return Wrap(
          children: [Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Zmień nazwę listy',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800]
                  ),
                ),
                const SizedBox(height: 20,),

                AuthTextField(hintText: 'Wprowadź nazwę listy', controller: changeNameController),

                const SizedBox(height: 20,),

                AuthButton(text: 'Zapisz', onTap: () {},),
              ],
            ),
          ),]
        );
      },
    );
  }
  
    void changeColor(BuildContext context){
    Navigator.pop(context);
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.grey[300],
      context: context,
      builder: (context) {
        return Wrap(
          children: [Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Zmień kolor listy',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800]
                  ),
                ),
                const SizedBox(height: 20,),

                ColorButtons(selections: _selections),

                const SizedBox(height: 20,),

                AuthButton(text: 'Zapisz', onTap: () {},),
              ],
            ),
          ),]
        );
      },
    );
  }

  void deleteList(){

  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: BlocBuilder<ShoppingListsBloc, ShoppingListsState>(
        builder: (context, state) {
          if (state is ShoppingListsLoaded) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: getColor(state.shoppingLists[index].color, 400), width: 2),
                borderRadius: BorderRadius.circular(10),
                color: getColor(state.shoppingLists[index].color, 200),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            state.shoppingLists[index].name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => moreOptions(context),
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey[800],
                            size: 28,
                          )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                      Expanded(
                          child: LinearProgressIndicator(
                          value: state.shoppingLists[index].calcBoughtRatio(),
                          color: Colors.green[400],
                          backgroundColor: getColor(state.shoppingLists[index].color, 100),
                          borderRadius: BorderRadius.circular(6),
                          minHeight: 13,
                        )),
                        const SizedBox(width: 20),
                        Text(state.shoppingLists[index].getProgress(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                )
              )
            );
          }else {
            return const Text('Listy niezaładowane');
          }
        },
      ),
    );
  }
}
