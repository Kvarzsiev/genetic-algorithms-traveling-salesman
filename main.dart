import 'chrommo.dart';

void sortChrommos(List<Chrommo> chrommos) {
  return chrommos.sort((a, b) => a.fitness - b.fitness);
}

void printChrommos(List<Chrommo> chrommos) {
  chrommos.forEach((chrommo) {
    chrommo.printSelf();
  });
}

void main() {
  List<Chrommo> chrommos =
      List.generate(5, (index) => Chrommo.fromRandom(id: index));

  sortChrommos(chrommos);

  print('Start (random chrommos)\n');
  printChrommos(chrommos);
}
