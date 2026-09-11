package com.Backend.music_app.repository;

import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Favorite;
import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, UUID> {

    // 1. Lấy danh sách các Bài hát Yêu thích của User (Phân trang, lấy bài mới thích lên đầu)
    @Query("""
        SELECT f.song FROM Favorite f
        JOIN f.song s
        LEFT JOIN FETCH s.artist
        LEFT JOIN FETCH s.album
        WHERE f.user.name = :userName
        ORDER BY f.createdAt DESC
    """)
    Page<Song> findFavoriteSongsByUserName(@Param("userName") String userName, Pageable pageable);

    // 2. Kiểm tra xem Bài hát này đã được User yêu thích chưa
    boolean existsByUserIdAndSongId(UUID userId, UUID songId);

    // 3. Tìm record Favorite theo userId và songId (dùng khi xóa khỏi danh sách yêu thích)
    Optional<Favorite> findByUserIdAndSongId(UUID userId, UUID songId);

    UUID user(User user);
}