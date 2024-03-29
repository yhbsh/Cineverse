import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../lib.dart';

class MoviesRepoImpl implements IMoviesRepo {
  final IMoviesRemoteDatasource _remoteDatasource;
  final INetworkInfo _networkInfo;

  MoviesRepoImpl(this._remoteDatasource, this._networkInfo);

  @override
  Future<Either<MovieFailure, MoviesEntity>> fetchMovies(FetchMoviesRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final moviesResponse =
            await _remoteDatasource.fetchMovies(type: request.type, page: request.page, genre: request.genre);
        final moviesEntity = MoviesEntity.fromResponse(moviesResponse);
        return right(moviesEntity);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, MoviesEntity>> fetchSearchMovies(FetchSearchMoviesRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final moviesResponse = await _remoteDatasource.fetchSearchMovies(
            query: request.query, page: request.page, includeAdult: request.includeAdult);
        final moviesEntity = MoviesEntity.fromResponse(moviesResponse);
        return right(moviesEntity);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, MovieDetailsEntity>> fetchMovieDetails(FetchMovieDetailsRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final movieDetailsResponse = await _remoteDatasource.fetchMovieDetails(movieId: request.movieId);
        final movieDetailsEntity = MovieDetailsEntity.fromResponse(movieDetailsResponse);
        return right(movieDetailsEntity);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, MovieImagesEntity>> fetchMovieImages(FetchMovieImagesRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final movieImagesResponse = await _remoteDatasource.fetchMovieImages(movieId: request.movieId);
        final movieImagesEntity = MovieImagesEntity.fromResponse(movieImagesResponse);
        return right(movieImagesEntity);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, Uint8List>> fetchPosterImage(FetchPosterImageRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final posterImage = await _remoteDatasource.fetchPosterImage(posterPath: request.posterPath);
        return right(posterImage);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, Uint8List>> fetchBackdropImage(FetchBackdropImageRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final backdropImage = await _remoteDatasource.fetchBackdropImage(backdropPath: request.backdropPath);
        return right(backdropImage);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, MovieCreditsEntity>> fetchMovieCredits(FetchMovieCreditsRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final movieCreditsResponse = await _remoteDatasource.fetchMovieCredits(movieId: request.movieId);
        final movieCreditsEntity = MovieCreditsEntity.fromResponse(movieCreditsResponse);
        return right(movieCreditsEntity);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }

  @override
  Future<Either<MovieFailure, MovieVideosEntity>> fetchMovieVideos(FetchMovieVideosRequest request) async {
    if (await _networkInfo.isConnected) {
      try {
        final movieVideosResponse = await _remoteDatasource.fetchMovieVideos(movieId: request.movieId);
        final movieVideosEntity = MovieVideosEntity.fromResponse(movieVideosResponse);
        return right(movieVideosEntity);
      } on MovieException catch (err) {
        final failure = MovieFailure(message: err.message, code: err.code);
        return left(failure);
      } catch (_) {
        log(_.toString());
        const failure = MovieFailure(message: AppFailureMessages.unknownError);
        return left(failure);
      }
    } else {
      const failure = MovieFailure(message: AppFailureMessages.noInternet);
      return left(failure);
    }
  }
}
