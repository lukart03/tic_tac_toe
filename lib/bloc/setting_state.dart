part of 'setting_cubit.dart';

@immutable
abstract class SettingState {
  final ThemeData theme;

  const SettingState({required this.theme});
}

class AppTheme extends SettingState {
  const AppTheme({required super.theme});
}
