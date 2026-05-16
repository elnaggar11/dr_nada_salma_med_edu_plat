class FavouriteParams{
  String? favouriteId;

  FavouriteParams({required this.favouriteId});

  Map<String,dynamic> toMap(){
    return {"favourite_id" : favouriteId};
  }
}