import 'package:prompt/models/selectable.dart';
import 'package:prompt/viewmodels/base_view_model.dart';

class SortableListViewModel extends BaseViewModel {
  List<Selectable> availableItems = [];
  List<Selectable> selectedItems = [];
  SortableListViewModel();

  SortableListViewModel.withInitialItems(this.availableItems);

  @override
  void dispose() {
    super.dispose();
  }

  void itemSelected(Selectable item) {
    if (item.isSelected) {
      selectedItems.add(item);
    } else {
      selectedItems.remove(item);
    }
    notifyListeners();
  }

  void reorderItems(int oldIndex, int newIndex) {
    if (newIndex > availableItems.length) {
      newIndex = availableItems.length;
    }
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = availableItems.removeAt(oldIndex);
    availableItems.insert(newIndex, item);
    notifyListeners();
  }

  swapItems(int indexA, int indexB) {
    if (indexA < 0 || indexB < 0) return;
    if (indexA > (selectedItems.length - 1) ||
        indexB > (selectedItems.length - 1)) return;
    var tmpB = selectedItems[indexB];
    selectedItems[indexB] = selectedItems[indexA];
    selectedItems[indexA] = tmpB;
    notifyListeners();
  }

  addSelectedItem() {
    var item = Selectable(
      name: 'custom ${selectedItems.length + 1}',
      description: "custom",
      iconPath: "",
      isSelected: true,
    );
    selectedItems.add(item);
    notifyListeners();
  }

  removeSelectedItem(String name) {
    selectedItems.removeWhere((item) => item.name == name);
    notifyListeners();
  }
}
