import 'package:flutter_test/flutter_test.dart';
import 'package:x03_architecture/login_page.dart';

void main() {
  test('test name', () {
    //setup
    //run
    //verify result
  });

  test('empty email returns error string', () {
    var result = EmailFieldValidator.validate('');
    expect(result, 'email can\'t be empty');
  });

  test('non-empty email returns null', () {
    var result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {
    var result = PasswordFieldValidator.validate('');
    expect(result, 'password can\'t be empty');
  });

  test('non-empty password returns null', () {
    var result = PasswordFieldValidator.validate('email');
    expect(result, null);
  });
}
