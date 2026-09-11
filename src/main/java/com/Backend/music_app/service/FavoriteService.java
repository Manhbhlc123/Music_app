package com.Backend.music_app.service;

import com.Backend.music_app.dto.response.FavoriteStatusResponse;
import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Favorite;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.User;
import com.Backend.music_app.exception.AppException;
import com.Backend.music_app.exception.ErrorCode;
import com.Backend.music_app.mapper.SongMapper;
import com.Backend.music_app.repository.FavoriteRepository;
import com.Backend.music_app.repository.SongRepository;
import com.Backend.music_app.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class FavoriteService {
    FavoriteRepository favoriteRepository;
    UserRepository userRepository;
    SongRepository songRepository;
    SongMapper songMapper;

    @Transactional
    public Page<SongItemResponse> getFavoriteSongs(String userName, Pageable pageable) {
        if (!userRepository.existsUsersByName(userName)) {
            throw new AppException(ErrorCode.USER_NOT_EXISTED);
        }
        return favoriteRepository
                .findFavoriteSongsByUserName(userName, pageable)
                .map(song -> songMapper.toSongItemResponse(songRepository.findById(song.getId()).orElseThrow(() -> new AppException(ErrorCode.SONG_NOT_FOUND))));
    }


    @Transactional
    public FavoriteStatusResponse toggleFavorite(String userName, UUID songId) {
        User user = userRepository.findUsersByName(userName).orElseThrow(() -> new AppException(ErrorCode.USER_NOT_EXISTED));

        Song song = songRepository.findById(songId).orElseThrow(() -> new AppException(ErrorCode.SONG_NOT_FOUND));
        Optional<Favorite> favoriteOtp = favoriteRepository.findByUserIdAndSongId(user.getId(), songId);

        if (favoriteOtp.isPresent()) {
            favoriteRepository.delete(favoriteOtp.get());
            return FavoriteStatusResponse.builder().songId(songId).isFavorite(false).message("đã xóa khỏi danh sách yêu thích").build();
        } else {
            Favorite favorite = Favorite.builder().user(user).song(song).build();
            favoriteRepository.save(favorite);

            return FavoriteStatusResponse.builder().songId(songId).isFavorite(true).message("Đã thêm vào danh sách yêu thích").build();
        }
    }

    @Transactional
    public boolean isFavorite(UUID userId, UUID songId) {
        return favoriteRepository.existsByUserIdAndSongId(userId, songId);
    }

}
