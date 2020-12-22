import 'package:raf_airlines_admin/models/airplane.dart';

abstract class AirplaneDAO {

  Future<List<Airplane>> getAllAirplanes();
}