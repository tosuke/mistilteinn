class ID {
  final String _id;

  ID(this._id);

  @override
  String toString() => _id;

  bool operator ==(other) {
    if (other is ID) {
      return _id == other.toString();
    } else {
      return false;
    }
  }

  int get hashCode => _id.hashCode;
}
