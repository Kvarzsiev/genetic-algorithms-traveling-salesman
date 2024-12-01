import 'dart:math';

class Chrommo {
  Chrommo({required this.id, required this.travelPoints, this.fitness = 0});

  factory Chrommo.fromRandom({required int id}) {
    final c = Chrommo(id: id, travelPoints: generateRandomTravel());

    c.calculateFitness();
    return c;
  }

  final int id;
  final List<int> travelPoints;
  int fitness;
  static final pointsTimeMatrix = [
    [0, 2, 9, 3, 6], // point 1
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

  void printSelf() {
    print(
        'Chrommo $id has fitness value of $fitness - Travel = $travelPoints \n');
  }
}
