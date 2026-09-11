package com.Backend.music_app.repository;

import com.Backend.music_app.entity.Song;
import com.Backend.music_app.entity.SongLyricSync;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SongLyricSyncRepository extends JpaRepository<SongLyricSync, UUID> {
    List<SongLyricSync> findBySongIdOrderByLineOrderAsc(UUID songId);

    @Modifying
    @Query("DELETE FROM SongLyricSync s WHERE s.song.id = :songId")
    void deleteAllBySongId(@Param("songId")UUID songId);
}
