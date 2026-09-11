package com.Backend.music_app.repository;

import com.Backend.music_app.entity.TrendingKeyword;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface TrendingKeywordRepository extends JpaRepository<TrendingKeyword, UUID> {
    Optional<TrendingKeyword> findByKeywordIgnoreCase(String keyword);

    List<TrendingKeyword> findTop10ByOrderBySearchCountDesc();
}
