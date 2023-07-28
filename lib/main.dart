import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toee/bloc/setting_cubit.dart';
import 'package:tic_tac_toee/bloc/tic_tac_toe_cubit.dart';
import 'package:tic_tac_toee/setting_screen.dart';
import 'package:tic_tac_toee/tic_tac_toe_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    cubit: SettingCubit(),
  ));
}

class MyApp extends StatelessWidget {
  final SettingCubit cubit;

  const MyApp({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => cubit..currentTheme()..currentFont(),
        ),
        BlocProvider(
          create: (context) => TicTacToeCubit(),
        ),
      ],
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.theme,
            home: TicTacToeScreen(),
          );
        },
      ),
    );
  }
}
