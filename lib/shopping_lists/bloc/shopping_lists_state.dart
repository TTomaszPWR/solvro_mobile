part of 'shopping_lists_bloc.dart';

sealed class ShoppingListsState extends Equatable {
  const ShoppingListsState();
  
  @override
  List<Object> get props => [];

  get shoppingLists => null;
}

class ShoppingListsLoading extends ShoppingListsState {}

class ShoppingListsLoaded extends ShoppingListsState {
  final List<ShoppingListModel> shoppingLists;

  const ShoppingListsLoaded(this.shoppingLists);

  @override
  List<Object> get props => [shoppingLists];
}

class ShoppingListsLoadingError extends ShoppingListsState {
  final String message;

  const ShoppingListsLoadingError(this.message);

  @override
  List<Object> get props => [message];
}

class ShoppingListsNotLoaded extends ShoppingListsState {}
