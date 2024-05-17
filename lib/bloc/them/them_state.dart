part of 'them_cubit.dart';

class ThemState extends Equatable {
  const ThemState(this.brightness);
  final Brightness brightness;

  get isDark => brightness == Brightness.dark;

  @override
  List<Object> get props => [brightness];
}
