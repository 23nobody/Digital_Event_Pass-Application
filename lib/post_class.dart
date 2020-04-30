import 'package:digitaleventpass/pages/enums.dart';

class Post {
	String _eventID;
	String _title;
	String _venue;
	String _organiserId;
	Post(this._title, this._venue, this._organiserId,
			this._eventTime, this._duration, this._eventDescription, this._imageUrl, this._eventType);

	DateTime _eventTime;
	double _duration;
	String _eventDescription;
	String _imageUrl;
	String _eventType;

	String get eventType => _eventType;

	set eventType(String value) {
		_eventType = value;
	}

	String get eventID => _eventID;

	set eventID(String value) {
		_eventID = value;
	}

	String get title => _title;

	String get imageUrl => _imageUrl;

	set imageUrl(String value) {
		_imageUrl = value;
	}

	String get eventDescription => _eventDescription;

	set eventDescription(String value) {
		_eventDescription = value;
	}

	double get duration => _duration;

	set duration(double value) {
		_duration = value;
	}

	DateTime get eventTime => _eventTime;

	set eventTime(DateTime value) {
		_eventTime = value;
	}



	set title(String value) {
		_title = value;
	}

	String get venue => _venue;

	set venue(String value) {
		_venue = value;
	}

	Map<String, dynamic> toJson() =>
			{
				'duration': _duration,
				'title' : _title,
				'eventTime' : _eventTime,
				'eventDescription' : _eventDescription,
				'imageUrl' : _imageUrl,
				'venue' : _venue,
				'organiserID' : _organiserId,
				'eventType' : _eventType,
			};

	String get organiserId => _organiserId;

	set organiserId(String value) {
		_organiserId = value;
	}

}




class Organiser{
	String organiserID;
	String contactNumber;
	String email;
	
}