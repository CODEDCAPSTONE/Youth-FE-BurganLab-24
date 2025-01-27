import 'package:flutter/material.dart';
import 'package:frontend/models/job.dart';
import 'package:frontend/models/offer.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/services/auth.dart';
import 'package:frontend/services/offers_and_jobs.dart';

class ExtraProvider extends ChangeNotifier {
  List<Offer> offers = [];
  List<Job> jobs = [];
  List<Job> appliedJobs = [];
  bool already = false;

  Future<List<Offer>> getOffers() async {
    // print("Getting offers");
    try {
      if (!already) {
        offers = await ExtraServices().getOffers();
        already = true;
      }
      // print(offers);
    } on Exception catch (_) {
      rethrow;
    }
    if (offers.isEmpty) throw("No Offers");
    return offers;
  }

  Future<List<Job>> getJobs() async {
    try {
      await AuthProvider().initAuth();
      jobs = await ExtraServices().getJobs();
      appliedJobs = await ExtraServices().getAppliedJobs();
      // print(cards[0].name);
      // print(cards[0].expiryDate);
    } on Exception catch (_) {
      rethrow;
    }
    if (jobs.isEmpty) throw("No Jobs");
    return jobs;
  }

  Future<List<Job>> getAppliedJobs() async {
    try {
      await AuthProvider().initAuth();
      appliedJobs = await ExtraServices().getAppliedJobs();
      // print(cards[0].name);
      // print(cards[0].expiryDate);
    } on Exception catch (_) {
      rethrow;
    }
    if (appliedJobs.isEmpty) throw("No Jobs");
    return appliedJobs;
  }

  Future applyJob({required String jobId}) async {
    try {
      // await AuthProvider().initAuth();
      final response = await ExtraServices().applyJob(jobId);
      return response;
      // print(cards[0].name);
      // print(cards[0].expiryDate);
    } on Exception catch (_) {
      rethrow;
    }
  }
}