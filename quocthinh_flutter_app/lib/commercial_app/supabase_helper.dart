import 'package:supabase_flutter/supabase_flutter.dart';


final supabase = Supabase.instance.client;
Future<void> removeImages({required String bucket,required String Path})async{
  await supabase
      .storage
      .from(bucket)
      .remove([Path]);
}
Stream<List<T>> getDataStream<T>({
  required String table,
  required List<String> ids,
  required T Function(Map <String,dynamic> json) fromJson
}){
var stream =supabase.from(table).stream(primaryKey:ids);
return stream.map((mapList)=>mapList.map(
(map) => fromJson(map),
).toList());
}

  Future<Map<int,T>> getMapData<T>({
    required String table,
    required T Function(Map <String,dynamic> json) fromJson,
    required int Function(T t) getID,
  }) async{
  final data = await supabase.from(table).select();
  var iterable = data.map((e) => fromJson(e),
  );
  Map<int,T> maps = Map.fromIterable(
  iterable,
    key: (t) => getID(t),value: (t) =>t ,);
  return maps;
  }


 listenFruitChangeData<T>(Map<int,T>maps, {
   required String channel,
   required String table,
   required String schema,
   required T Function(Map <String,dynamic> json) fromJson,
   required int Function(T ) getID,
   Function()? updateUI

})asyn{

  supabase
      .channel(channel)
      .onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: schema,
      table: table,
      callback: (payload) {
        print('Change received: ${payload.toString()}');
        switch(payload.eventType){
          case PostgresChangeEvent.insert :{
           T t = fromJson(payload.newRecord);
            maps[getID(t)]=t;
            updateUI?.call();
            break;
          }
          case PostgresChangeEvent.update :{
            T t = fromJson(payload.newRecord);
            maps[getID(t)]=t;
            updateUI?.call();
            break;
          }
          case PostgresChangeEvent.delete :{
            maps.remove(payload.oldRecord["id"]);
            updateUI?.call();
          }
          default:{}
        }
      })
      .subscribe();
}
