import '_index.dart';

abstract class Selection<T> {
  bool get useStaging;
  bool get singleValue;

  SelectionState<T> get state;

  void toggle(T value);
  void select(T value);
  void deselect(T value);

  bool isSelected(T value);

  void selectAll(List<T> values);
  void deselectAll();

  void applyStaging();
  void discardStaging();
}
