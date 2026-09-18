import 'package:flutter/cupertino.dart';
import 'package:sq_mp3/data/model/Album_model.dart';
import 'package:sq_mp3/data/model/Artist_model.dart';
import 'package:sq_mp3/data/model/genre_model.dart';
import 'package:sq_mp3/modules/admin/widget/AlbumManagement_widget/Album_item.dart';
import 'package:sq_mp3/modules/admin/widget/ArtistManagement_widget/Artist_item.dart';
import 'package:sq_mp3/modules/admin/widget/GenreManagement_widget/Genre_item.dart';

class GenresSectionAdmin extends StatelessWidget {
  final List<GenresModel> listGenres;
  final Function(GenresModel genre) onEdit;
  final Function(String genreId) onRemove;

  const GenresSectionAdmin({
    super.key,
    required this.listGenres,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        GenresModel genresModel = listGenres[index];
        return GenreItemAdmin(
          genresModel: genresModel,
          onUpdate: (genreModel) => onEdit(genreModel),
          onDelete: () => onRemove(genresModel.id),
        );
      },
      itemCount: listGenres.length,
    );
  }
}
