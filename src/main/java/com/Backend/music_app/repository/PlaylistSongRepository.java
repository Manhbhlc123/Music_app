package com.Backend.music_app.repository;

import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.PlaylistSong;
import com.Backend.music_app.entity.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PlaylistSongRepository extends JpaRepository<PlaylistSong, UUID> {
    List<PlaylistSong> findAllByPlaylistIdOrderByOrderIndexAsc(UUID playlistId);

    boolean existsByPlaylistIdAndSongId(UUID playlistId, UUID songId);

    //lấy order lớn nhất trong 1 playlist
    //dùng COALESCE để nếu playlist rỗng thì trả về -1
    @Query("SELECT coalesce(max(ps.orderIndex), -1) from PlaylistSong ps where ps.playlist.id = :playlistId")
    Integer findMaxOrderIndexByPlaylistId(@Param("playlistId") UUID playlistId);

    // Cách tối ưu: Trả về thẳng List<Song> và sắp xếp theo order_index
    @Query("""
        SELECT ps.song FROM PlaylistSong ps 
        WHERE ps.playlist.id = :playlistId 
        ORDER BY ps.orderIndex ASC
    """)
    List<Song> findSongsByPlaylistId(@Param("playlistId") UUID playlistId);
}
