import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toee/bloc/setting_cubit.dart';
import 'package:tic_tac_toee/bloc/tic_tac_toe_cubit.dart';
import 'package:tic_tac_toee/setting_screen.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late TicTacToeCubit cubit;

  String get message {
    if (cubit.state is PlayWithAI && cubit.winX) {
      return 'You won!!!';
    } else if (cubit.state is PlayWithAI && !cubit.winX) {
      return 'You lose(';
    } else if (cubit.state is PlayParty && cubit.winX) {
      return 'X player won!!!';
    } else if (cubit.state is PlayParty && !cubit.winX) {
      return 'O player won!!!';
    } else {
      return '';
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = context.read<TicTacToeCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(
            color: context.read<SettingCubit>().isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
            icon: Icon(
              Icons.settings,
              color: context.read<SettingCubit>().isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
      body: BlocBuilder<TicTacToeCubit, TicTacToeState>(
        builder: (context, state) {
          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      cubit.move(index);
                      if (cubit.isGameEnd) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.only(top: 18, left: 26),
                                actionsAlignment: MainAxisAlignment.center,
                                actionsPadding:
                                    const EdgeInsets.only(bottom: 12, top: 14),
                                buttonPadding: const EdgeInsets.all(60),
                                titlePadding: const EdgeInsets.only(top: 18),
                                title: Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    letterSpacing: 0.25,
                                    color: Color(0xFF222222),
                                    fontSize: 16,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      cubit.fields =
                                          List.generate(9, (index) => 'e');
                                      cubit.isGameEnd = false;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: _buildPVPSymbol(index),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TicTacToeCubit>()
                                  .playingState(false);
                              cubit.fields =
                                  List.generate(9, (index) => 'e');
                              cubit.isGameEnd = false;
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  state is! PlayWithAI ? Colors.white : null,
                            ),
                            child: const Text(
                              'PVE',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ))),
                    const SizedBox(width: 30),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  state is! PlayParty ? Colors.white : null,
                            ),
                            onPressed: () {
                              cubit.fields =
                                  List.generate(9, (index) => 'e');
                              cubit.isGameEnd = false;
                              context.read<TicTacToeCubit>().playingState(true);
                              setState(() {});
                            },
                            child: const Text(
                              'PVP',
                              style: TextStyle(color: Colors.black),
                            ))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    cubit.fields = List.generate(9, (index) => 'e');
                    cubit.isGameEnd = false;
                    setState(() {});
                  },
                  child: Text(
                    'Refresh',
                    style: TextStyle(
                      color: context.read<SettingCubit>().isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPVPSymbol(int index) {
    if (cubit.fields[index] != 'e' && cubit.fields[index] != 'o') {
      return const Icon(Icons.close, size: 60);
    } else if (cubit.fields[index] != 'e' && cubit.fields[index] != 'x') {
      return const Icon(Icons.circle_outlined, size: 50);
    } else {
      return const SizedBox.shrink();
    }
  }
}
