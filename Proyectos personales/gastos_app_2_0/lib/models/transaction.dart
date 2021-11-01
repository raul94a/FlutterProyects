class Transaction {
  String id;
  String? title;
  double? amount;
  DateTime? date;
  Transaction(this.id, this.title, this.amount, this.date);

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "amount": amount, "date": date.toString()};
  @override
  String toString() {
    // TODO: implement toString
    return "id: ${id}\ntitle: $title\namount: $amount\n ${date.toString()}";
  }
}
