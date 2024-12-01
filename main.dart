import 'chromo.dart';
import 'chromo_list_extensions.dart';

void main(List<String> args) {
  final startListLength = args.length > 0 ? int.parse(args.first) : 2;

  List<Chromo> chromos = [];

  do {
    chromos.defaultRoutine(startListLength);
  } while (!chromos
      .any((element) => element.id.contains('m') && element.fitness == 11));
}
