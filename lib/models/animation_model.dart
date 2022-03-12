import 'package:equatable/equatable.dart';

/// {@template animation}
/// Rive animation path and name.
/// {@endtemplate}
class AnimationModel extends Equatable {
  /// {@macro animation}
  const AnimationModel({
    required this.name,
    required this.path,
  });

  /// The name of the animation.
  final String name;

  /// The asset path of the animation.
  final String path;

  @override
  List<Object> get props => [name, path];
}
