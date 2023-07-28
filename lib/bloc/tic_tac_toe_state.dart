part of 'tic_tac_toe_cubit.dart';

@immutable
abstract class TicTacToeState {}

class TicTacToeInitial extends TicTacToeState {}

class PlayWithAI extends TicTacToeState {}

class PlayParty extends TicTacToeState {}
