abstract class AppStates {

  String get nameState;
  @override
  String toString() {
    return nameState;
  }
}

class InitialAppState extends AppStates {
  @override
  String get nameState => "initial state";
}

class ChangeBottomState extends AppStates {
  @override
  String get nameState => "ChangeBottomState";
}

class ChangeSelectedDayInWeekTable extends AppStates { @override
String get nameState => "ChangeSelectedDayInWeekTable";}

class ConnectingToMySql extends AppStates { @override
String get nameState => "ConnectingToMySql";}
class ConnectedToMySql extends AppStates {
  @override
  String get nameState => "ConnectedToMySql";
}


class DisConnectingToMySql extends AppStates {
  @override
  String get nameState => "DisConnectingToMySql";
}
class DisConnectedToMySql extends AppStates {
  @override
  String get nameState => "DisConnectedToMySql";
}

class GetDataFromDB extends AppStates {
  @override
  String get nameState => "GetDataFromDB1";
}
