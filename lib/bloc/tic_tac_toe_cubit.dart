import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tic_tac_toe_state.dart';

class TicTacToeCubit extends Cubit<TicTacToeState> {
  List<String> fields = List.generate(9, (index) => 'e');
  List<int> listOfEmpty = [];
  bool currentPlayer = true;
  bool isGameEnd = false;
  bool winX = false;

  TicTacToeCubit() : super(PlayWithAI());

  void playingState(bool isPvp) {
    if (isPvp) {
      emit(PlayParty());
    } else {
      emit(PlayWithAI());
    }
  }

  void move(int index) {
    if (!isGameEnd){
      if (state is PlayWithAI && fields[index] == 'e') {
        fields[index] = 'x';
        for (int i = 0; i < fields.length; i++) {
          if (fields[i] == 'e') {
            listOfEmpty.add(i);
          }
        }
        fields[listOfEmpty[Random().nextInt(listOfEmpty.length)]] = 'o';
        listOfEmpty.clear();
      } else if (state is PlayParty && fields[index] == 'e') {
        if (currentPlayer) {
          fields[index] = 'x';
          currentPlayer = false;
        } else {
          fields[index] = 'o';
          currentPlayer = true;
        }
      }
    }
    if (fields[0] == fields[1] && fields[0] == fields[2] && fields[0] == 'x' ||
        fields[3] == fields[4] && fields[3] == fields[5] && fields[3] == 'x' ||
        fields[6] == fields[7] && fields[6] == fields[8] && fields[6] == 'x' ||
        fields[0] == fields[3] && fields[0] == fields[6] && fields[0] == 'x' ||
        fields[1] == fields[4] && fields[1] == fields[7] && fields[1] == 'x' ||
        fields[2] == fields[5] && fields[2] == fields[8] && fields[2] == 'x' ||
        fields[0] == fields[4] && fields[0] == fields[8] && fields[0] == 'x' ||
        fields[2] == fields[4] && fields[2] == fields[6] && fields[2] == 'x') {
      isGameEnd = true;
      winX = true;
    } else if (fields[0] == fields[1] && fields[0] == fields[2] && fields[0] == '0' ||
        fields[3] == fields[4] && fields[3] == fields[5] && fields[3] == 'o' ||
        fields[6] == fields[7] && fields[6] == fields[8] && fields[6] == 'o' ||
        fields[0] == fields[3] && fields[0] == fields[6] && fields[0] == 'o' ||
        fields[1] == fields[4] && fields[1] == fields[7] && fields[1] == 'o' ||
        fields[2] == fields[5] && fields[2] == fields[8] && fields[2] == 'o' ||
        fields[0] == fields[4] && fields[0] == fields[8] && fields[0] == 'o' ||
        fields[2] == fields[4] && fields[2] == fields[6] && fields[2] == 'o') {
      isGameEnd = true;
      winX = false;
    }
  }
}
