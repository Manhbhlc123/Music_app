package com.Backend.music_app.repository;

import com.Backend.music_app.entity.AlbumSong;
import com.Backend.music_app.entity.PlaylistSong;
import com.Backend.music_app.entity.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface AlbumSongRepository extends JpaRepository<AlbumSong, UUID> {
    List<AlbumSong> findAllByAlbumIdOrderByOrderIndexAsc(UUID albumId);

    boolean existsByAlbumIdAndSongId(UUID albumId, UUID songId);

    //lấy order lớn nhất trong 1 playlist
    //dùng COALESCE để nếu album rỗng thì trả về -1
    @Query("SELECT coalesce(max(al.orderIndex), -1) from AlbumSong al where al.album.id = :albumId")
    Integer findMaxOrderIndexByAlbumId(@Param("albumId") UUID albumId);

    // Cách tối ưu: Trả về thẳng List<Song> và sắp xếp theo order_index
    @Query("""
        SELECT al.song FROM AlbumSong al
        WHERE al.album.id = :albumId
        ORDER BY al.orderIndex ASC
    """)
    List<Song> findSongsByAlbumId(@Param("albumId") UUID albumId);
}
