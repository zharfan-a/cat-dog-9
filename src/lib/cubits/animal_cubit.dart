
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/animal_model.dart';

// AnimalState class
class AnimalState extends Equatable {
	final Animal animal;

	const AnimalState({required this.animal});

	static AnimalState animal(Animal animal) => AnimalState(animal: animal);

	@override
	List<Object?> get props => [animal];
}

// AnimalCubit class
class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState.animal(Animal.cat));

	void toggleAnimal() {
		final newAnimal = state.animal == Animal.cat ? Animal.dog : Animal.cat;
		emit(AnimalState.animal(newAnimal));
	}
}
