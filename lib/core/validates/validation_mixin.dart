class ValidationMixin {
  String? validatePassword(value) {
    if (value.length == 0) {
      return "Lütfen Geçerli Bir Password Giriniz  ";
    }
    return null;
  }

  String? validateEmailName(value) {
    if (!value.contains("@")) {
      // emailin için @ harfi var mı yok mu diye teyit ettiriyorum
      return "Email Geçersizdir Lütfen Tekrar Deneyiniz !";
    }
    return null;
  }
}
