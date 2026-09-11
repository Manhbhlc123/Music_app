package com.Backend.music_app.repository;

import com.Backend.music_app.entity.Song;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SongRepository extends JpaRepository<Song, UUID> {
    boolean existsSongByTitle(String title);


    @Query("""
         SELECT DISTINCT s FROM Song s
         LEFT JOIN s.artist a
         LEFT JOIN s.album al
         WHERE LOWER(s.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(s.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(a.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(a.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(al.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(al.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR EXISTS (
                SELECT 1 FROM PlaylistSong ps
                JOIN ps.playlist p
                WHERE ps.song = s
                  AND LOWER(p.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
            )
         ORDER BY s.playCount DESC
    """)
    List<Song> search(@Param("keyword") String keyword, Pageable pageable);

    // Lấy Top bài hát có playCount cao nhất của một Artist
    @Query("SELECT s FROM Song s WHERE s.artist.id = :artistId ORDER BY s.playCount DESC")
    List<Song> findTopSongsByArtist(@Param("artistId") UUID artistId, Pageable pageable);


    @Modifying
    @Query("""
                    UPDATE Song s
                    SET s.playCount = s.playCount + 1
                    WHERE s.id = :songId
            """)
    void increasePlayCount(@Param("songId") UUID songId);


}
