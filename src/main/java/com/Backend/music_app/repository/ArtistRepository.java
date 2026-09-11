package com.Backend.music_app.repository;

import com.Backend.music_app.dto.response.Item.SongItemResponse;
import com.Backend.music_app.entity.Artist;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface ArtistRepository extends JpaRepository<Artist, UUID> {
    boolean existsGenresByName(String name);

    Artist findArtistById(UUID id);

    boolean existsByName(String name);

    @Query("""
         SELECT DISTINCT a FROM Artist a
         LEFT JOIN Song s ON s.artist = a
         WHERE LOWER(a.name) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(a.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR LOWER(s.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
            OR EXISTS (
                SELECT 1 FROM Album al
                WHERE al.artist = a
                  AND (
                      LOWER(al.title) LIKE LOWER(CONCAT('%', :keyword, '%'))
                   OR LOWER(al.searchKeywords) LIKE LOWER(CONCAT('%', :keyword, '%'))
                  )
            )
         ORDER BY a.name ASC
    """)
    List<Artist> search(@Param("keyword") String keyword, Pageable pageable);
}
