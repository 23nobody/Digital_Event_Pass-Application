import 'package:digitaleventpass/pages/enums.dart';

class Person{
	String _personID;
	String _name;
	String _email;
	Gender _gender;
	String _contactNumber;
	String _imageUrl;
	bool _isPaid;
	DateTime _dob;
	AccountType _accountType;

	Person(this._name, this._email, this._gender,
			this._contactNumber, this._imageUrl, this._dob){
		_isPaid = false;
		_accountType = AccountType.Guest;

	}


	bool get isPaid => _isPaid;

	set isPaid(bool value) {
		_isPaid = value;
	}

	String get name => _name;

	set name(String value) {
		_name = value;
	}

	String get email => _email;

	set email(String value) {
		_email = value;
	}

	String get contactNumber => _contactNumber;

	set contactNumber(String value) {
		_contactNumber = value;
	}

	String get imageUrl => _imageUrl;

	set imageUrl(String value) {
		_imageUrl = value;
	}

	AccountType get accountType => _accountType;

	set accountType(AccountType value) {
		_accountType = value;
	}

	DateTime get dob => _dob;

	set dob(DateTime value) {
		_dob = value;
	}

	String get personID => _personID;

	set personID(String value) {
		_personID = value;
	}

	Gender get gender => _gender;

	set gender(Gender value) {
		_gender = value;
	}


}