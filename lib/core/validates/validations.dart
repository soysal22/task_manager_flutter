class Validations {
  String? validateName(value) {
    if (value.length < 2) {
      return "Lütfen Geçerli Bir Name Giriniz  ";
    }
    return null;
  }

  String? validatePassword(value) {
    if (value.length == 0) {
      return "Lütfen Geçerli Bir Password Giriniz  ";
    }
    return null;
  }

  String? validateEmailName(value) {
    if (!value.contains("@")) {
      // emailin için @ harfi var mı yok mu diye teyit ettiriyorum
      return "Lütfen Geçerli Email Giriniz !";
    }
    return null;
  }
}
