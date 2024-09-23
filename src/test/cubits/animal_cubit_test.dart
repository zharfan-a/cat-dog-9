
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';

// Mocking dependencies if any
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is AnimalState(cat)', () {
			expect(animalCubit.state, equals(AnimalState.animal(Animal.cat)));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(dog)] when toggleAnimal is called from initial state',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState.animal(Animal.dog)],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits [AnimalState(cat)] when toggleAnimal is called from dog state',
			build: () {
				animalCubit.emit(AnimalState.animal(Animal.dog));
				return animalCubit;
			},
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [AnimalState.animal(Animal.cat)],
		);
	});
}
