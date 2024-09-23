
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:animal_switcher/widgets/animal_display.dart';

// Mock Cubit
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalDisplay Widget Tests', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('displays cat with clock icon initially', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays dog with person icon when state changes', (WidgetTester tester) async {
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([AnimalState(animal: Animal(name: 'Dog', icon: Icons.person))]),
				initialState: AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles between cat and dog on tap', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));
			when(() => mockAnimalCubit.toggleAnimal()).thenAnswer((_) {});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			verify(() => mockAnimalCubit.toggleAnimal()).called(1);
		});
	});
}
