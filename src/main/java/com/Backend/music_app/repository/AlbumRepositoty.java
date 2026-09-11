package com.Backend.music_app.repository;

import com.Backend.music_app.entity.Album;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.UUID;

public interface AlbumRepositoty extends JpaRepository<Album, UUID> {
    boolean existsAlbumsByTitle(String title);

    @Query("""
         SELECT DISTINCT al FROM Album al
         LEFT JOIN al.artist a
         WHERE LOWER(al.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(al.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(a.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(a.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR EXISTS (
                SELECT 1 FROM Song s
                WHERE s.album = al
                  AND (
                      LOWER(s.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
                   OR LOWER(s.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
                  )
            )
         ORDER BY al.releaseDate DESC
    """)
    List<Album> search(@Param("keyword") String keyword, Pageable pageable);

    @Query("""
        select a from Album a where a.artist.id = :artistId
""")
    List<Album> findAlbumsByArtistId(@Param("artistId") UUID artistId, Pageable pageable);


}
