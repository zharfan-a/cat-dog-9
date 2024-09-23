
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.animal_switcher/main.dart';

// Mocking AnimalCubit to use in tests
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalSwitcher App Tests', () {
		// Define the mock cubit
		final mockAnimalCubit = MockAnimalCubit();

		setUp(() {
			// Any setup needed before each test runs
		});

		tearDown(() {
			// Clean up after each test runs
		});

		group('Main Initialization', () {
			testWidgets('App starts and displays HomeScreen with initial state', (WidgetTester tester) async {
				await tester.pumpWidget(
					MaterialApp(
						home: BlocProvider<AnimalCubit>(
							create: (_) => mockAnimalCubit,
							child: HomeScreen(),
						),
					),
				);
				// Expect initial state to display cat with clock icon
				expect(find.text('Cat'), findsOneWidget);
				expect(find.byIcon(Icons.access_time), findsOneWidget);
			});
		});

		group('Cubit State Management', () {
			blocTest<AnimalCubit, AnimalState>(
				'AnimalCubit should emit new state when toggleAnimal is called',
				build: () => mockAnimalCubit,
				act: (cubit) => cubit.toggleAnimal(),
				expect: () => [isA<AnimalState>()], // Assuming the state changes correctly
			);
		});

		group('Widget Interaction', () {
			testWidgets('Tapping on text should toggle between Cat and Dog', (WidgetTester tester) async {
				// Initial state: Cat with clock icon
				whenListen(
					mockAnimalCubit,
					Stream.fromIterable([
						AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
						AnimalState(animal: Animal(name: 'Dog', icon: Icons.person)),
					]),
					initialState: AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time))
				);

				await tester.pumpWidget(
					MaterialApp(
						home: BlocProvider<AnimalCubit>(
							create: (_) => mockAnimalCubit,
							child: HomeScreen(),
						),
					),
				);

				// Verify initial state
				expect(find.text('Cat'), findsOneWidget);
				expect(find.byIcon(Icons.access_time), findsOneWidget);

				// Simulate tap
				await tester.tap(find.text('Cat'));
				await tester.pumpAndSettle();

				// Verify state after tap
				expect(find.text('Dog'), findsOneWidget);
				expect(find.byIcon(Icons.person), findsOneWidget);
			});
		});
	});
}
