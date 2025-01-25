import 'package:dio/dio.dart';
import 'package:frontend/models/job.dart';
import 'package:frontend/models/offer.dart';
import 'package:frontend/services/client.dart';

class ExtraServices {
  Future getOffers() async {
    List<Offer> offers;
    try {
      Response response = await Client.dio.get('/offer');
      offers = (response.data as List).map((offer) {
        return Offer.fromJson(offer);
      }).toList();

    } on DioException catch (_) {
      rethrow;
    }
    return offers;
  }

  Future getJobs() async {
    List<Job> jobs;
    try {
      Response response = await Client.dio.get('/job');
      jobs = (response.data as List).map((job) {
        return Job.fromJson(job);
      }).toList();

    } on DioException catch (_) {
      rethrow;
    }
    return jobs;
  }
}