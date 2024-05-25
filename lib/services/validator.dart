class Validator{
  static bool validateString(String? value){
    return value != null && value.isNotEmpty;
  }
  static bool validateInt(String? value){
    return value != null && int.tryParse(value) != null;
  }
}