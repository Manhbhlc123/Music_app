package com.Backend.music_app.repository;

import com.Backend.music_app.entity.SearchHistory;
import com.Backend.music_app.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface SearchHistoryRepository extends JpaRepository<SearchHistory, UUID> {
    List<SearchHistory> findTop10ByUserOrderBySearchedAtDesc(User user);

    void deleteByUser(User user);

    void deleteByUserAndKeyword(User user, String keyword);
}
