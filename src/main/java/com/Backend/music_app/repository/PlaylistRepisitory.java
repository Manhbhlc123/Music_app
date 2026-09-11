package com.Backend.music_app.repository;


import com.Backend.music_app.entity.Playlist;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PlaylistRepisitory extends JpaRepository<Playlist, UUID> {
    List<Playlist> findAllByUserNameOrderByCreatedAtAsc(String userName);

    boolean existsPlaylistByTitle(String title);

    void deleteByTitle(String title);

    void deletePlaylistById(UUID id);

    boolean existsPlaylistByIsSystemAndTitle(boolean isSystem, String title);

    List<Playlist> findAllByIsSystem(boolean isSystem);

    @Query("""
         SELECT DISTINCT p FROM Playlist p
         LEFT JOIN p.playlistSongs ps
         LEFT JOIN ps.song s
         LEFT JOIN s.artist a
         WHERE LOWER(p.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(p.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(a.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(s.title) LIKE LOWER(CONCAT('%', :keyword, '%')) 
    """)
    List<Playlist> search(@Param("keyword") String keyword, Pageable pageable);
}
