

import 'package:faps_demonstrator_customer_app/services/restclient.dart';

abstract class NetworkService {
  RestClient rest;
  NetworkService(this.rest);
}
