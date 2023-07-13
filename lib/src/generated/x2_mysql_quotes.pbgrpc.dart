//
//  Generated code. Do not modify.
//  source: x2_mysql_quotes.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'x2_mysql_quotes.pb.dart' as $0;

export 'x2_mysql_quotes.pb.dart';

class QuotesRetrieverClient extends $grpc.Client {
  static final _$returnData =
      $grpc.ClientMethod<$0.DataRequest, $0.DataReply>('/QuotesRetriever/ReturnData', ($0.DataRequest value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.DataReply.fromBuffer(value));
  static final _$returnDataByID = $grpc.ClientMethod<$0.DataRequest, $0.DataReply>(
      '/QuotesRetriever/ReturnDataByID', ($0.DataRequest value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.DataReply.fromBuffer(value));

  QuotesRetrieverClient($grpc.ClientChannel channel, {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.DataReply> returnData($0.DataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$returnData, request, options: options);
  }

  $grpc.ResponseFuture<$0.DataReply> returnDataByID($0.DataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$returnDataByID, request, options: options);
  }
}

abstract class QuotesRetrieverServiceBase extends $grpc.Service {
  $core.String get $name => 'QuotesRetriever';

  QuotesRetrieverServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DataRequest, $0.DataReply>(
        'ReturnData', returnData_Pre, false, false, ($core.List<$core.int> value) => $0.DataRequest.fromBuffer(value), ($0.DataReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DataRequest, $0.DataReply>(
        'ReturnDataByID', returnDataByID_Pre, false, false, ($core.List<$core.int> value) => $0.DataRequest.fromBuffer(value), ($0.DataReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.DataReply> returnData_Pre($grpc.ServiceCall call, $async.Future<$0.DataRequest> request) async {
    return returnData(call, await request);
  }

  $async.Future<$0.DataReply> returnDataByID_Pre($grpc.ServiceCall call, $async.Future<$0.DataRequest> request) async {
    return returnDataByID(call, await request);
  }

  $async.Future<$0.DataReply> returnData($grpc.ServiceCall call, $0.DataRequest request);
  $async.Future<$0.DataReply> returnDataByID($grpc.ServiceCall call, $0.DataRequest request);
}
