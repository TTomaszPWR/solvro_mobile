import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solvro_basket_buddy/auth/bloc/auth_bloc.dart';
import 'package:solvro_basket_buddy/auth/model/token_model.dart';
import 'package:solvro_basket_buddy/products/bloc/product_bloc.dart';
import 'package:solvro_basket_buddy/shopping_lists/bloc/shopping_lists_bloc.dart';
import 'package:solvro_basket_buddy/shopping_lists/components/shopping_list_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {

    final listIndex = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_item', arguments: listIndex);
        },
        backgroundColor: Colors.grey[700],
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[300],
      
      body: BlocBuilder<ShoppingListsBloc, ShoppingListsState>(
        builder: (context, state) {
          if (state is ShoppingListsLoaded) {
            return ListView.separated(
              itemCount: state.shoppingLists[listIndex].items.length,
              itemBuilder: (context, index) {
                return ShoppingListItem(listIndex: listIndex, itemIndex: index);
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }if (state is ShoppingListsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}