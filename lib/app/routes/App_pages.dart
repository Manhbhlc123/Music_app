import 'package:get/get.dart';
import 'package:sq_mp3/app/routes/App_routes.dart';
import 'package:sq_mp3/modules/admin/binding/Admin_binding.dart';
import 'package:sq_mp3/modules/admin/view/AlbumManage_view.dart';
import 'package:sq_mp3/modules/admin/view/Home_admin.dart';
import 'package:sq_mp3/modules/admin/view/PlaylistManage_view.dart';
import 'package:sq_mp3/modules/admin/view/SongManage_view.dart';
import 'package:sq_mp3/modules/admin/view/UserManage_view.dart';
import 'package:sq_mp3/modules/admin/widget/UserManagement_widget/Create_user.dart';
import 'package:sq_mp3/modules/favorite/binding/Favorite_binding.dart';
import 'package:sq_mp3/modules/favorite/view/Favorite_view.dart';
import 'package:sq_mp3/modules/home/binding/Home_binding.dart';
import 'package:sq_mp3/modules/home/binding/Login_binding.dart';
import 'package:sq_mp3/modules/home/binding/SignUp_binding.dart';
import 'package:sq_mp3/modules/Home_view.dart';
import 'package:sq_mp3/modules/home/binding/SongsOfArtist_binding.dart';
import 'package:sq_mp3/modules/home/view/Login_view.dart';
import 'package:sq_mp3/modules/home/view/PlaylistDetail_view.dart';
import 'package:sq_mp3/modules/home/view/SignUp_view.dart';
import 'package:sq_mp3/modules/home/view/SongsOfArtist_view.dart';
import 'package:sq_mp3/modules/library/binding/Library_binding.dart';
import 'package:sq_mp3/modules/library/view/Album_view.dart';
import 'package:sq_mp3/modules/library/view/Download_view.dart';
import 'package:sq_mp3/modules/library/view/FollowedArtist_view.dart';
import 'package:sq_mp3/modules/library/view/MyPlaylist_view.dart';
import 'package:sq_mp3/modules/library/view/detail/AlbumDetail_view.dart';
import 'package:sq_mp3/modules/player/binding/Player_binding.dart';
import 'package:sq_mp3/modules/player/view/Play_view.dart';
import 'package:sq_mp3/modules/player/widges/PlayerMiniBar.dart';
import 'package:sq_mp3/modules/profile/binding/Profile_binding.dart';
import 'package:sq_mp3/modules/profile/view/Detail_profile.dart';
import 'package:sq_mp3/modules/profile/view/Profile_view.dart';
import 'package:sq_mp3/modules/search/Binding/Search_binding.dart';
import 'package:sq_mp3/modules/search/views/Search_result_page.dart';
import 'package:sq_mp3/modules/search/views/Search_view.dart';

class AppPages {
  static const INITIAL = Routes.login;

  static final pages = [
    //login binding
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    //sign up binding
    GetPage(
      name: Routes.signup,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),

    GetPage(
      name: Routes.createUserFromAdminPage,
      page: () => const CreateUser(),
      binding: SignUpBinding(),
    ),

    //Home binding
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: Routes.playlistDetail,
      page: () => const PlaylistDetailView(),
      binding: HomeBinding(),
    ),

    //Song of artist binding
    GetPage(
      name: Routes.songsOfArtist,
      page: () => const SongsofartistView(),
      binding: SongsOfArtistBinding(),
    ),

    //search binding
    GetPage(
      name: Routes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),

    GetPage(
      name: Routes.searchResult,
      page: () => const SearchResultPage(),
      binding: SearchBinding(),
    ),

    //favorite binding
    GetPage(
      name: Routes.favorite,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),

    //profile binding
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: Routes.detailProfile,
      page: () => const DetailProfile(),
      binding: ProfileBinding(),
    ),

    //player binding
    GetPage(
      name: Routes.playerView,
      page: () => const PlayerView(),
      binding: PlayerBinding(),
    ),

    GetPage(
      name: Routes.playerMiniBar,
      page: () => const PlayerMiniBar(),
      binding: PlayerBinding(),
    ),

    //library binding
    GetPage(
      name: Routes.followedArtist,
      page: () => const FollowedArtist(),
      binding: LibraryBinding(),
    ),

    GetPage(
      name: Routes.album,
      page: () => const Album(),
      binding: LibraryBinding(),
    ),

    GetPage(
      name: Routes.playlistLibrary,
      page: () => const MyPlaylistView(),
      binding: LibraryBinding(),
    ),

    GetPage(
      name: Routes.albumDetail,
      page: () => const AlbumDetailView(),
      binding: LibraryBinding(),
    ),

    GetPage(
      name: Routes.download,
      page: () => const DownloadView(),
      binding: LibraryBinding(),
    ),

    //admin binding
    GetPage(
      name: Routes.adminHome,
      page: () => const HomeAdmin(),
      binding: AdminBinding(),
    ),

    GetPage(
      name: Routes.userManagement,
      page: () => const UserManageView(),
      binding: AdminBinding(),
    ),

    GetPage(
      name: Routes.songManagement,
      page: () => const SongManageView(),
      binding: AdminBinding(),
    ),

    GetPage(
      name: Routes.playlistManagement,
      page: () => const PlaylistManageView(),
      binding: AdminBinding(),
    ),

    GetPage(
      name: Routes.albumManagement,
      page: () => const AlbumManageView(),
      binding: AdminBinding(),
    ),
  ];
}
