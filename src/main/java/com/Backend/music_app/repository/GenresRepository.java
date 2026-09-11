package com.Backend.music_app.repository;

import com.Backend.music_app.entity.Genres;
import lombok.Builder;
import lombok.Data;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface GenresRepository extends JpaRepository<Genres, UUID> {
    boolean existsGenresByName(String name);
}
