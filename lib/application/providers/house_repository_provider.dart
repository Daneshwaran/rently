import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/repositories/house_repository_impl.dart';
import '../../domain/repositories/house_repository.dart';

final houseRepositoryProvider = Provider<HouseRepository>((ref) {
  return HouseRepositoryImpl();
});
