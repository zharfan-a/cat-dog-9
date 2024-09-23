
import 'package:flutter_test/flutter_test.dart';
import 'package:animal_switcher/models/animal_model.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should have correct name and icon', () {
			const catIcon = Icons.access_time;
			const dogIcon = Icons.person;

			final cat = Animal(name: 'Cat', icon: catIcon);
			final dog = Animal(name: 'Dog', icon: dogIcon);

			expect(cat.name, 'Cat');
			expect(cat.icon, catIcon);

			expect(dog.name, 'Dog');
			expect(dog.icon, dogIcon);
		});

		test('Animal model should support serialization and deserialization', () {
			const catIcon = Icons.access_time;
			final cat = Animal(name: 'Cat', icon: catIcon);

			final json = cat.toJson();
			final newCat = Animal.fromJson(json);

			expect(newCat.name, cat.name);
			expect(newCat.icon, cat.icon);
		});
	});
}
