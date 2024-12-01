import 'dart:math';

class Chromo {
  Chromo({required this.id, required this.travelPoints, this.fitness = 0});

  factory Chromo.fromRandom({required int id}) {
    final c = Chromo(id: id.toString(), travelPoints: generateRandomTravel());

    c.calculateFitness();
    return c;
  }

  factory Chromo.fromOrderCrossover({
    required Chromo parent1,
    required Chromo parent2,
  }) {
    // mid slice from p2
    final baseSlice = parent2.travelPoints.sublist(1, 3);

    // Gets an ordered list from p1, but without the elements already present in baseSlice
    final baseRoute = List.of(parent1.travelPoints)
      ..removeWhere((element) => baseSlice.contains(element));

    // Inserts the slice at index 1 (at this moment base route should have only 3 elements);
    final newRoute = baseRoute..insertAll(1, baseSlice);

    final c = Chromo(id: '${parent1.id}+${parent2.id}', travelPoints: newRoute);

    c.calculateFitness();
    return c;
  }

  String id;
  final List<int> travelPoints;
  int fitness;
  static final pointsTimeMatrix = [
    [0, 2, 9, 3, 6], // point 1 and the distance between it and the other points
    [2, 0, 4, 3, 8], // point 2
    [9, 4, 0, 7, 3], // point 3
    [3, 3, 7, 0, 3], // point 4
    [6, 8, 3, 3, 0], // point 5
  ];

  static List<int> generateRandomTravel() {
    final rand = Random();
    final List<int> travel = [];

    while (travel.length < 5) {
      final generated = rand.nextInt(5);
      if (!travel.contains(generated)) {
        travel.add(generated);
      }
    }

    return travel;
  }

  void calculateFitness() {
    int fitVal = 0;

    for (int j = 0; j < travelPoints.length - 1; j++) {
      final currentPoint = pointsTimeMatrix[travelPoints[j]];
      final travelTime = currentPoint[travelPoints[j + 1]];
      fitVal += travelTime;
    }

    fitness = fitVal;
  }

  // Around 14% of mutaion chance
  void mutate() {
    final rand = Random();

    // if random number is multiple of 7
    if (rand.nextInt(100) % 7 == 0) {
      this.id += 'm';

      // swap 2 random points
      final mutationPoint1 = rand.nextInt(5);
      final indexOfPoint1 = this.travelPoints.indexOf(mutationPoint1);
      final mutationPoint2 = rand.nextInt(5);
      final indexOfPoint2 = this.travelPoints.indexOf(mutationPoint2);

      this.travelPoints
        ..setAll(indexOfPoint1, [mutationPoint2])
        ..setAll(indexOfPoint2, [mutationPoint1]);

      this.calculateFitness();
    }
  }

  void printSelf() {
    print(
        'Chromosome $id has fitness value of $fitness - Travel Route = $travelPoints \n');
  }
}
