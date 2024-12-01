import 'chromo.dart';

extension ChromoList on List<Chromo> {
  void sortChromos() {
    return this.sort((a, b) => a.fitness - b.fitness);
  }

  void printChromos() {
    this.forEach((chromo) {
      chromo.printSelf();
    });
  }

  void crossover() {
    final List<Chromo> newList = [];

    if (length >= 2) {
      for (int i = 0; i < this.length; i++) {
        final nextChromo = this.elementAtOrNull(i + 1) ?? this[0];

        newList.add(
            Chromo.fromOrderCrossover(parent1: this[i], parent2: nextChromo));

        newList.add(
            Chromo.fromOrderCrossover(parent1: nextChromo, parent2: this[i]));

        // won't run again if length is equal to 2
        if (this.length == 2) {
          break;
        }
      }
    }

    print('After Crossover \n');
    this
      ..replaceRange(0, this.length, newList)
      ..printChromos();
  }

  void mutate() {
    print('After Mutating (14% chance of mutating for each chromo) \n');
    this
      ..forEach((e) => e.mutate())
      ..printChromos();
  }

  void defaultRoutine(int startListLength) {
    this.replaceRange(
        0,
        this.length,
        List.generate(startListLength, (index) => Chromo.fromRandom(id: index))
          ..sortChromos());

    print('Start (random chromos)\n');
    this
      ..printChromos()
      ..crossover()
      ..mutate();
  }
}
